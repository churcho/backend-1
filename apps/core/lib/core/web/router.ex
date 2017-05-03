defmodule Core.Web.Router do
  use Core.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
  end

  scope "/api", Core.Web do
    pipe_through :api
    scope "/v1" do

      # Resources
      resources "/settings", SettingController, except: [:new, :edit]
      resources "/locations", LocationController, except: [:new, :edit]
      resources "/location_types", LocationTypeController, except: [:new, :edit]
      resources "/entity_types", EntityTypeController, except: [:new, :edit]
      resources "/entities", EntityController do
        get  "/events", EntityController, :entity_events
        post "/events", EntityController, :create_event
      end
      resources "/zones", ZoneController, except: [:new, :edit]
      resources "/rooms", RoomController, except: [:new, :edit]
      resources "/events", EventController, except: [:new, :edit]
      resources "/users", UserController, except: [:new, :edit]
      resources "/roles", RoleController, except: [:new, :edit]
      resources "/users", UserController, except: [:new, :edit]
      # Route to actions
      resources "/actions", ActionController, except: [:new, :edit]
      # Route to services
      resources "/services", ServiceController do
        get  "/events", ServiceController, :service_events
        post "/events", ServiceController, :create_event
      end
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
