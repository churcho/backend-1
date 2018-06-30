defmodule Core.Accounts.Supervisor do
  @moduledoc false
  use Supervisor

  alias Core.Accounts

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init([
      Accounts.Projectors.User,
      Accounts.Projectors.Role
    ], strategy: :one_for_one)
  end

end
