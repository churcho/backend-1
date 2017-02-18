defmodule Iotapi.Providers do
  alias Iotapi.Provider
  alias Iotapi.Repo

  def register(provider) do
    changeset = Provider.changeset(%Provider{}, provider)
    Repo.insert(changeset)
  end

  def unregister(provider) do

  end



end
