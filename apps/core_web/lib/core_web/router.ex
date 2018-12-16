defmodule CoreWeb.Router do
  @moduledoc false
  use CoreWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :jwt_authenticated do
    plug CoreWeb.Guardian.AuthPipeline
  end


  scope "/api", CoreWeb do
    pipe_through([:api])
    scope "/v1" do
      pipe_through(:jwt_authenticated)
      #Protected Auth
      get("/current_user", CurrentUserController, :show)
      delete("/sessions", SessionController, :delete)

      scope "/places" do
        resources("/locations", LocationController, except: [:new, :edit])
        resources("/zones", ZoneController, except: [:new, :edit])
        resources("/rooms", RoomController, except: [:new, :edit])
      end

      get("/ability", AbilityController, :index)

      scope "/services" do
        resources("/providers", ProviderController, except: [:new, :edit])
        resources("/connections", ConnectionController, except: [:new, :edit])
      end

      scope "/accounts" do
        resources("/roles", RoleController, except: [:new, :edit])
      end

      scope "/people" do

        resources("/profiles", ProfileController, except: [:new, :edit])
      end

    end
    scope "/v1" do
      # Route to register a new user
      post("/registrations", RegistrationController, :create)
      # Routes to log in and log out
      post("/sessions", SessionController, :create)
    end
  end
end
