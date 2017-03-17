defmodule Core.Providers do
  alias Core.Provider
  alias Core.Repo

  def register(provider) do
    changeset = Provider.changeset(%Provider{}, provider)
    Repo.insert(changeset)
  end

  def unregister(provider) do

  end



end
