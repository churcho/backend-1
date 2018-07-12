defmodule CoreWeb.AbilityController do
  use CoreWeb, :controller
  alias Core.Ability

  def index(conn, _params) do
    list = Ability.list()
    render(conn, "index.json", list:  list)
  end
end
