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
      resources("/settings", SettingController, except: [:new, :edit])
      resources("/locations", LocationController, except: [:new, :edit])
      resources("/location_types", LocationTypeController, except: [:new, :edit])
      resources("/entity_types", EntityTypeController, except: [:new, :edit])


      resources "/entities", EntityController do
        resources("/property_types", EntityPropertyTypeController, except: [:new, :edit], as: :property_type)
        resources("/event_types", EntityEventTypeController, except: [:new, :edit], as: :event_type)
        resources("/action_types", EntityActionTypeController, except: [:new, :edit], as: :action_type)
        get("/events", EntityController, :get_entity_events, as: :event)
        post("/events", EntityController, :create_event, as: :event)
        get("/properties", EntityController, :get_entity_properties, as: :properties)
        get("/properties/:property_id", EntityController, :show_entity_property, as: :properties)
        put("/properties/:property_id", EntityController, :set_entity_property, as: :properties)
        get("/actions", EntityController, :get_entity_actions, as: :actions)
      end

      resources("/zones", ZoneController, except: [:new, :edit])
      resources("/rooms", RoomController, except: [:new, :edit])
      resources("/events", EventController, except: [:new, :edit])
      resources("/users", UserController, except: [:new, :edit])
      resources("/roles", RoleController, except: [:new, :edit])
      resources("/users", UserController, except: [:new, :edit])
      # Route to actions
      resources("/actions", ActionController, except: [:new, :edit])
      # Route to properties
      resources("/boolean_properties", BooleanPropertyController, except: [:new, :edit])

      # Route to services
      resources "/services", ServiceController do
        get("/events", ServiceController, :service_events, as: :events)
        post("/events", ServiceController, :create_event, as: :events)
      end

      # Route to providers
      resources("/providers", ProviderController, except: [:new, :edit])
      # Route to register a new user
      post("/registrations", RegistrationController, :create)

      post("/entities/update_state", EntityController, :update_state)
      # Routes to log in and log out
      post("/sessions", SessionController, :create)
      delete("/sessions", SessionController, :delete)

      # Route for the current user
      get("/current_user", CurrentUserController, :show)
    end
  end

  scope "/" do
    forward "/graph", Absinthe.Plug, schema: CoreWeb.Schema
    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: CoreWeb.Schema
  end
end
