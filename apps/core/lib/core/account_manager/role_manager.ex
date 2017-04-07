defmodule Core.RoleManager do
  @moduledoc """
  Manages roles throughout the API

  ##Admin

  ##User

  ##Guest


  Accounts will be assigned one role at a time. The first user will always be granted the administrator
  role. Once there is at least one admin, that user will be responsible for granting roles.
  """

  def grant_role(user) do
  	users = Core.Repo.all(Core.User)
  	if length(users) == 1 do
  		role = Core.Repo.get_by(Core.Role, name: "Admin")

  		user_params = %{role_id: role.id}

  		changeset = Core.User.changeset_profile(user, user_params)

  		case Core.Repo.update(changeset) do
  			{:ok, user} ->
  				loaded_user = Core.Repo.get(Core.User, user.id)

          loaded_user
  				|> Core.Repo.preload(:role)

  			_ ->
          nil


  		end

  	else
  		role = Core.Repo.get_by(Core.Role, name: "Guest")

  		user_params = %{role_id: role.id}

  		changeset = Core.User.changeset_profile(user, user_params)

  		case Core.Repo.update(changeset) do
  			{:ok, user} ->

          loaded_user = Core.Repo.get(Core.User, user.id)

          loaded_user
          |> Core.Repo.preload(:role)

  			_ ->
  				nil

  		end
  	end
  end


end
