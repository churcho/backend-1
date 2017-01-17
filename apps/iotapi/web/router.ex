defmodule Iotapi.Router do
  use Iotapi.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
  end

  scope "/api", Iotapi do
    pipe_through :api
    scope "/v1" do

      # Resources
      resources "/events", EventController, except: [:new, :edit]
      resources "/services", ServiceController, except: [:new, :edit]

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
