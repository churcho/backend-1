defmodule Core.ProviderManager do
  @moduledoc """
  The boundary for the ServiceManager system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Core.Repo

  alias Core.ProviderManager.Provider

  @doc """
  Returns the list of providers.

  ## Examples

    iex> list_providers()
    [%Provider{}, ...]

  """
  def list_providers do
    Provider
    |> Repo.all()
    |> Repo.preload([
      :services
      ])
  end

  @doc """
  Gets a single Provider.

  Raises `Ecto.NoResultsError` if the Provider does not exist.

    ## Examples

      iex> get_provider!(123)
      %Provider{}

      iex> get_provider!(456)
      ** (Ecto.NoResultsError)

  """

  def get_provider!(id) do
    Provider
    |> Repo.get!(id)
    |> Repo.preload([:services])
  end

  @doc """
  Gets a single Provider by its LORP name.

  Raises `Ecto.NoResultsError` if the Provider does not exist.

    ## Examples

      iex> get_provider_by_lorp_name("lorp_name")
      %Provider{}

      iex> get_provider_lorp_name(456)
      ** (Ecto.NoResultsError)

  """
  def get_provider_by_lorp_name(lorp_name) do
    Provider
    |> Repo.get_by(lorp_name: lorp_name)
    |> Repo.preload([:services])
  end

  @doc """
  Creates a Provider.

  ## Examples

    iex> create_provider(%{field: value})
    {:ok, %Provider{}}

    iex> create_provider(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_provider(attrs \\ %{}) do
    %Provider{}
    |> Provider.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates OR updates a Provider if none exists.

  ## Examples

    iex> create_or_update_provider(%{field: value})
    {:ok, %Provider{}}

    iex> create_or_update_provider(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_or_update_provider(target) do
    result =
      case Repo.get_by(Provider, lorp_name: target.lorp_name) do
        nil -> Provider.changeset(%Provider{}, target)
        provider -> Provider.changeset(provider, target)
      end

    result
    |> Repo.insert_or_update()
  end

  @doc """
  Updates a Provider.

  ## Examples

    iex> update_provider(Provider, %{field: new_value})
    {:ok, %Provider{}}

    iex> update_provider(Provider, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def update_provider(%Provider{} = provider, attrs) do
    provider
    |> Provider.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Provider.

  ## Examples

    iex> delete_provider(Provider)
    {:ok, %Provider{}}

    iex> delete_provider(Provider)
    {:error, %Ecto.Changeset{}}

  """
  def delete_provider(%Provider{} = provider) do
    provider
    |> Repo.delete()
  end


  @doc """
  Returns an `%Ecto.Changeset{}` for tracking Provider changes.

  ## Examples

    iex> change_provider(Provider)
    %Ecto.Changeset{source: %Provider{}}

  """
  def change_provider(%Provider{} = provider) do
    Provider.changeset(provider, %{})
  end

end
