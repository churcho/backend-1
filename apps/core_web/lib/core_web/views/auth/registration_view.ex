defmodule CoreWeb.RegistrationView do
  @moduledoc false
  use CoreWeb, :view

  def render("error.json", error) do
    %{error: error}
  end
end
