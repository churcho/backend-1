defmodule Core.People.Commands.CreateRole do
  @moduledoc """
  Create a role
  """

    defstruct [
      role_uuid: "",
      name: "",
      label: "",
      description: ""
    ]

    use ExConstructor
    use Vex.Struct

    alias Core.People.Commands.CreateRole
    alias Core.People.Validators.UniqueRoleName

    validates :role_uuid, uuid: true

    validates :name,
    presence: [message: "can't be empty"],
    format: [
      with: ~r/^[a-z0-9]+$/, allow_nil: true, allow_blank: true, message: "is invalid"
      ],
    string: true,
    by: &UniqueRoleName.validate/2

    @doc """
    Assign a unique identity for the role
    """
    def assign_uuid(%CreateRole{} = create_role, uuid) do
      %CreateRole{create_role | role_uuid: uuid}
    end

    @doc """
    Convert name to lowercase characters
    """
    def downcase_name(%CreateRole{name: name} = create_role) do
      %CreateRole{create_role | name: String.downcase(name)}
    end

    defimpl Core.Support.Middleware.Uniqueness.UniqueFields,
      for: Core.People.Commands.CreateRole
    do
      def unique(%Core.People.Commands.CreateRole{role_uuid: role_uuid}), do: [
        {:name, "has already been taken", role_uuid}
      ]
    end
  end
