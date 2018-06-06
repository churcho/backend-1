defmodule Core.Places.Supervisor do
  @moduledoc false
  use Supervisor

  alias Core.Places

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init([
      Places.Projectors.Location
    ], strategy: :one_for_one)
  end

end
