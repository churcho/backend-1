defmodule Core.Router do
  use Core.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
  end

  scope "/api", Core do
    pipe_through :api
    scope "/v1" do

      # Resources
      resources "/settings", SettingController, except: [:new, :edit]
      resources "/locations", LocationController, except: [:new, :edit]
      resources "/entities", EntityController, except: [:new, :edit]
      resources "/zones", ZoneController, except: [:new, :edit]
      resources "/rooms", RoomController, except: [:new, :edit]
      resources "/events", EventController, except: [:new, :edit]
      resources "/users", UserController, except: [:new, :edit]
      resources "/roles", RoleController, except: [:new, :edit]
      # Route to services
      resources "/services", ServiceController, except: [:new, :edit]
      # Route to providers
      resources "/providers", ProviderController, except: [:new, :edit]
      # Route to register a new user
      post "/registrations", RegistrationController, :create

      # Routes to log in and log out
      post "/sessions", SessionController, :create
      delete "/sessions", SessionController, :delete

      # Route for the current user
      get "/current_user", CurrentUserController, :show
    end

  end
end
