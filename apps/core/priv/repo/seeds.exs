# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Core.Repo.insert!(%Core.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Core.Accounts
alias Core.EntityManager
alias Core.EntityManager.{
  AttributeTemplates,
  CommandTemplates
}

Accounts.create_role(%{
  name: "admin",
  label: "Administrator",
  description: "Administrator of the system"
})
Accounts.create_role(%{
  name: "user",
  label: "User",
  description: "User of the system"
})
Accounts.create_role(%{
  name: "guest",
  label: "Guest",
  description: "Guest of the system"
})

Enum.each(AttributeTemplates.return_list, fn(x) ->
  EntityManager.create_attribute(x)
end)

Enum.each(CommandTemplates.return_list, fn(x) ->
  EntityManager.create_command(x)
end)
