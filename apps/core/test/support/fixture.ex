defmodule Core.Fixture do
  @moduledoc false
  import Core.Factory

  alias Core.{Accounts}

  def register_user(_context) do
    {:ok, user} = fixture(:user)

    [
      user: user,
    ]
  end

  def fixture(resource, attrs \\ [])
  def fixture(:user, attrs) do
    build(:user, attrs) |> Accounts.register_user()
  end

end
