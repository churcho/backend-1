defmodule Core.People.Aggregates.Role do
  @moduledoc false
  defstruct [
    :uuid,
    :name,
    :label,
    :description
  ]

  alias Core.People.Aggregates.Role
  alias Core.People.Commands.{
    CreateRole,
    UpdateRole
  }
  alias Core.People.Events.{
    RoleNameChanged,
    RoleLabelChanged,
    RoleDescriptionChanged,
    RoleCreated
  }

  @doc """
  Create a new Role
  """
  def execute(%Role{uuid: nil}, %CreateRole{} = create) do
    %RoleCreated{
      role_uuid: create.role_uuid,
      name: create.name,
      description: create.description,
      label: create.label,
    }
  end

  @doc """
  Update a role's name, description, and label
  """
  def execute(%Role{} = role, %UpdateRole{} = update) do
    Enum.reduce([
      &name_changed/2, &label_changed/2, &description_changed/2
      ], [], fn (change, events) ->
      case change.(role, update) do
        nil -> events
        event -> [event | events]
      end
    end)
  end

  # state mutators

  def apply(%Role{} = role, %RoleCreated{} = created) do
    %Role{role |
      uuid: created.role_uuid,
      name: created.name,
      description: created.description,
      label: created.label,
    }
  end

  def apply(%Role{} = role, %RoleNameChanged{name: name}) do
    %Role{role | name: name}
  end

  def apply(%Role{} = role, %RoleLabelChanged{label: label}) do
    %Role{role | label: label}
  end

  def apply(%Role{} = role, %RoleDescriptionChanged{description: description}) do
    %Role{role | description: description}
  end

  # private helpers

  defp name_changed(%Role{}, %UpdateRole{name: ""}), do: nil
  defp name_changed(%Role{name: name}, %UpdateRole{name: name}), do: nil
  defp name_changed(%Role{uuid: role_uuid}, %UpdateRole{name: name}) do
    %RoleNameChanged{
      role_uuid: role_uuid,
      name: name,
    }
  end

  defp description_changed(%Role{}, %UpdateRole{description: ""}), do: nil
  defp description_changed(%Role{description: description}, %UpdateRole{description: description}), do: nil
  defp description_changed(%Role{uuid: role_uuid}, %UpdateRole{description: description}) do
    %RoleDescriptionChanged{
      role_uuid: role_uuid,
      description: description,
    }
  end

  defp label_changed(%Role{}, %UpdateRole{label: ""}), do: nil
  defp label_changed(%Role{label: label}, %UpdateRole{label: label}), do: nil
  defp label_changed(%Role{uuid: role_uuid}, %UpdateRole{label: label}) do
    %RoleLabelChanged{
      role_uuid: role_uuid,
      label: label,
    }
  end
end
