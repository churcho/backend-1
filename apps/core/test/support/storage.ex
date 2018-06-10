defmodule Core.Storage do
  @moduledoc false

  alias EventStore.Config
  alias EventStore.Storage.Initializer

  @doc """
  Clear the event store and read store databases
  """
  def reset! do
    :ok = Application.stop(:core)
    :ok = Application.stop(:commanded)
    :ok = Application.stop(:eventstore)

    reset_eventstore()
    reset_readstore()

    {:ok, _} = Application.ensure_all_started(:core)
  end

  defp reset_eventstore do
    {:ok, conn} =
      EventStore.configuration()
      |> Config.parse()
      |> Config.default_postgrex_opts()
      |> Postgrex.start_link()

    Initializer.reset!(conn)
  end

  defp reset_readstore do
    readstore_config = Application.get_env(:core, Core.Repo)

    {:ok, conn} = Postgrex.start_link(readstore_config)

    Postgrex.query!(conn, truncate_readstore_tables(), [])
  end

  defp truncate_readstore_tables do
    """
    TRUNCATE TABLE
      users,
      projection_versions
    RESTART IDENTITY;
    """
  end
end