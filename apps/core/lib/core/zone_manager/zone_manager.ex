defmodule Core.ZoneManager do
  @moduledoc """
  The boundary for the LocationManager system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Core.Repo

  alias Core.ZoneManager.Zone

  @doc """
  Returns the list of zones.

  ## Examples

    iex> list_zones()
    [%Zone{}, ...]

  """
  def list_zones do
    Zone
  	|> Repo.all()
  	|> Repo.preload([:location, :rooms])
  end

  @doc """
  Gets a single Zone.

  Raises `Ecto.NoResultsError` if the Zone does not exist.

  ## Examples

    iex> get_zone!(123)
    %Zone{}

    iex> get_zone!(456)
    ** (Ecto.NoResultsError)

 	"""
   def get_zone!(id) do
    Zone
    |> Repo.get!(id)
  	|> Repo.preload([:location, :rooms])
  end

  @doc """
  Creates a Zone.

  ## Examples

    iex> create_zone(%{field: value})
    {:ok, %Zone{}}

    iex> create_zone(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_zone(attrs \\ %{}) do
    %Zone{}
    |> Zone.changeset(attrs)
    |> Repo.insert()

  end

  @doc """
  Updates a Zone.

  ## Examples

    iex> update_zone(Zone, %{field: new_value})
    {:ok, %Zone{}}

    iex> update_zone(Zone, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def update_zone(%Zone{} = zone, attrs) do
    zone
    |> Zone.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Zone.

  ## Examples

    iex> delete_zone(Zone)
    {:ok, %Zone{}}

    iex> delete_zone(Zone)
    {:error, %Ecto.Changeset{}}

  """
  def delete_zone(%Zone{} = zone) do
    Repo.delete(zone)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking Zone changes.

    ## Examples

      iex> change_zone(Zone)
      %Ecto.Changeset{source: %Zone{}}

  """
  def change_zone(%Zone{} = zone) do
    Zone.changeset(zone, %{})
  end
end
