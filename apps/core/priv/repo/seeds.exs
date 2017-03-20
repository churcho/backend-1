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


Core.Repo.insert!(%Core.Role{name: "Admin", description: "Administrator of the system"})
Core.Repo.insert!(%Core.Role{name: "User", description: "User of the system"})
Core.Repo.insert!(%Core.Role{name: "Guest", description: "Guest of the system"})