defmodule Core.People.Commands.CreateProfile do
  @moduledoc """
  Create a profile
  """

    defstruct [
      profile_uuid: "",
      user_uuid: "",
      username: "",
      first_name: "",
      last_name: "",
      user_uuid: "",
    ]

    use ExConstructor
    use Vex.Struct

    alias Core.People.Commands.CreateProfile

    validates :profile_uuid, uuid: true
    validates :user_uuid, uuid: true

    @doc """
    Assign a unique identity for the profile
    """
    def assign_uuid(%CreateProfile{} = create_profile, uuid) do
      %CreateProfile{create_profile | profile_uuid: uuid}
    end
  end
