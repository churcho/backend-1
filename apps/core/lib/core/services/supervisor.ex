defmodule Core.Services.Supervisor do
  @moduledoc false
  use Supervisor

  alias Core.Services

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init([
      Services.Projectors.Provider,
      Services.Projectors.Connection,
      Services.Projectors.Entity
    ], strategy: :one_for_one)
  end

end
