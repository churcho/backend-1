defmodule Core.People.Workflows.CreateProfileFromUser do
  @moduledoc false
  use Commanded.Event.Handler,
    name: "People.Workflows.CreateProfileFromUser",
    consistency: :strong

  alias Core.Accounts.Events.UserRegistered
  alias Core.People

  def handle(%UserRegistered{user_uuid: user_uuid}, _metadata) do
    with {:ok, _profile} <-
      People.create_profile(%{user_uuid: user_uuid})
    do
      :ok
    else
      reply -> reply
    end
  end
end
