defmodule Core.EntityController do
  use Core.Web, :controller

  alias Core.Entity

  def index(conn, _params) do
    entities = Repo.all(Entity)
     |> Repo.preload([:service])
    render(conn, "index.json", entities: entities)
  end

  def create(conn, %{"entity" => entity_params}) do
    changeset = Entity.changeset(%Entity{}, entity_params)

    case Repo.insert(changeset) do
      {:ok, entity} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", entity_path(conn, :show, entity))
        |> render("show.json", entity: entity)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Core.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    entity = Repo.get!(Entity, id)
    |> Repo.preload([:service])
    render(conn, "show.json", entity: entity)
  end

  def entity_events(conn, %{"entity_id" => entity_id}) do
    sorted = (from e in Core.Event, 
              where: e.entity_id == ^entity_id, 
              order_by: [desc: e.id],
              limit: 100)
              |> Repo.all()

    render(conn, "entity_events.json", events: sorted)

  end

  def update(conn, %{"id" => id, "entity" => entity_params}) do
    entity = Repo.get!(Entity, id)
    changeset = Entity.changeset(entity, entity_params)

    case Repo.update(changeset) do
      {:ok, entity} ->
        render(conn, "show.json", entity: entity)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Core.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    entity = Repo.get!(Entity, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(entity)

    send_resp(conn, :no_content, "")
  end
end
