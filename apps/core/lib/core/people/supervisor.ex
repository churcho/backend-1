defmodule Core.People.Supervisor do
  @moduledoc false
  use Supervisor

  alias Core.People

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init([
      People.Projectors.Profile,
      People.Workflows.CreateProfileFromUser,
    ], strategy: :one_for_one)
  end

end
