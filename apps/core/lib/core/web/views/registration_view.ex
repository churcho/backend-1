defmodule Core.Web.RegistrationView do
  @moduledoc false
  use Core.Web, :view

  def render("error.json", error) do
    IO.inspect error
    %{error: error}
  end
end
