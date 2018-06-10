defmodule Core.People.Commands.UpdateProfile do
  @moduledoc false
  defstruct [
    profile_uuid: "",
    user_uuid: "",
    username: "",
    first_name: "",
    last_name: "",
    user_uuid: ""
  ]

  use ExConstructor
  use Vex.Struct

  alias Core.People.Commands.UpdateProfile
  alias Core.People.Projections.Profile

  validates :profile_uuid, uuid: true
  validates :user_uuid, uuid: true

  @doc """
  Assign the profile identity
  """
  def assign_profile(%UpdateProfile{} = update_profile, %Profile{uuid: profile_uuid}) do
    %UpdateProfile{update_profile | profile_uuid: profile_uuid}
  end
end
