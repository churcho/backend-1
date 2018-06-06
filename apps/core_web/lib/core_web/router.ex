defmodule CoreWeb.Router do
  @moduledoc false
  use CoreWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(Guardian.Plug.VerifyHeader)
    plug(Guardian.Plug.LoadResource)
  end

  scope "/api", CoreWeb do
    pipe_through(:api)

    scope "/v1" do
      # Resources
      resources("/users", UserController, except: [:new, :edit])
      resources("/roles", RoleController, except: [:new, :edit])
      # Route to register a new user
      post("/registrations", RegistrationController, :create)
      # Routes to log in and log out
      post("/sessions", SessionController, :create)
      delete("/sessions", SessionController, :delete)

      # Route for the current user
      get("/current_user", CurrentUserController, :show)

      scope "/places" do
        resources("/locations", LocationController, except: [:new, :edit])
      end
    end
  end
end
