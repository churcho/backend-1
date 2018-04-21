defmodule Core.Application do
 @moduledoc """
  The Wonka Application Service.

  The wonka system business domain lives in this application.

  Exposes API to clients such as the `WonkaWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Core.Repo, []),
    ], strategy: :one_for_one, name: Core.Supervisor)
  end

end
