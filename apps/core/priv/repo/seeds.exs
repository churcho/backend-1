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
alias Core.Registry
alias Core.Registry.Templates.{
  AttributeTemplate,
  CommandTemplate
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

Enum.each(AttributeTemplate.return_list, fn(x) ->
  Registry.create_attribute(x)
end)

Enum.each(CommandTemplate.return_list, fn(x) ->
  Registry.create_command(x)
end)
