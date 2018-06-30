defmodule Core.Accounts.Projectors.Role do
  @moduledoc false
  use Commanded.Projections.Ecto,
    name: "Accounts.Projectors.Role",
    consistency: :strong

  alias Core.Accounts.Events.{
    RoleNameChanged,
    RoleDescriptionChanged,
    RoleLabelChanged,
    RoleCreated,
  }
  alias Core.Accounts.Projections.Role
  alias Ecto.Multi

  project %RoleCreated{} = created do
    Multi.insert(multi, :role, %Role{
      uuid: created.role_uuid,
      name: created.name,
      description: created.description,
      label: created.label,
    })
  end

  project %RoleNameChanged{role_uuid: role_uuid, name: name} do
    update_role(multi, role_uuid, name: name)
  end

  project %RoleDescriptionChanged{
    role_uuid: role_uuid, description: description}
  do
    update_role(multi, role_uuid, description: description)
  end

  project %RoleLabelChanged{role_uuid: role_uuid, label: label} do
    update_role(multi, role_uuid, label: label)
  end

  defp update_role(multi, role_uuid, changes) do
    Multi.update_all(multi, :role, role_query(role_uuid), set: changes)
  end

  defp role_query(role_uuid) do
    from(r in Role, where: r.uuid == ^role_uuid)
  end
end
