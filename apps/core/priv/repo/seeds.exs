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
