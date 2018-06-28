defmodule Core.Places.Aggregates.Location do
  @moduledoc false
  defstruct [
    uuid: nil,
    name: nil,
    address_one: nil,
    address_two: nil,
    address_city: nil,
    address_country: nil,
    address_state: nil,
    address_zip: nil,
    slug: nil,
    description: nil,
    latitude: nil,
    longitude: nil,
    location_type: nil,
    zones: nil,
    deleted?: false,
  ]

  alias Core.Places.Aggregates.Location
  alias Core.Places.Commands.{
    CreateLocation,
    UpdateLocation,
    DeleteLocation
  }

  alias Core.Places.Events.{
    LocationCreated,
    LocationDeleted,
    LocationNameChanged,
    LocationDescriptionChanged,
    LocationAddressOneChanged,
    LocationAddressTwoChanged,
    LocationAddressCityChanged,
    LocationAddressCountryChanged,
    LocationAddressStateChanged,
    LocationAddressZipChanged
  }

  @doc """
  Create a new Location
  """
  def execute(%Location{uuid: nil}, %CreateLocation{} = create) do
    %LocationCreated{
      location_uuid: create.location_uuid,
      name: create.name,
      description: create.description,
      address_one: create.address_one,
      address_two: create.address_two,
      address_city: create.address_city,
      address_country: create.address_country,
      address_state: create.address_state,
      address_zip: create.address_zip
    }
  end

  @doc """
  Update a location's name, description
  """
  def execute(%Location{} = location, %UpdateLocation{} = update) do
    Enum.reduce([
      &name_changed/2,
      &description_changed/2,
      &address_one_changed/2,
      &address_two_changed/2,
      &address_city_changed/2,
      &address_country_changed/2,
      &address_state_changed/2,
      &address_zip_changed/2
      ], [], fn (change, events) ->
      case change.(location, update) do
        nil -> events
        event -> [event | events]
      end
    end)
  end

  @doc """
  Delete an existing Location
  """
  def execute(
    %Location{uuid: location_uuid, deleted?: false},
    %DeleteLocation{location_uuid: location_uuid})
  do
    %LocationDeleted{location_uuid: location_uuid}
  end

  @doc """
  Stop the location aggregate after it has been deleted
  """
  def after_event(%LocationDeleted{}), do: :stop
  def after_event(_), do: :timer.hours(1)

  # state mutators

  def apply(%Location{} = location, %LocationCreated{} = created) do
    %Location{location |
      uuid: created.location_uuid,
      name: created.name,
      description: created.description,
    }
  end

  def apply(%Location{} = location, %LocationDeleted{}) do
    %Location{location| deleted?: true}
  end

  def apply(%Location{} = location, %LocationNameChanged{name: name}) do
    %Location{location | name: name}
  end

  def apply(%Location{} = location, %LocationDescriptionChanged{description: description}) do
    %Location{location | description: description}
  end

  def apply(%Location{} = location, %LocationAddressOneChanged{address_one: address_one}) do
    %Location{location | address_one: address_one}
  end

  def apply(%Location{} = location, %LocationAddressTwoChanged{address_two: address_two}) do
    %Location{location | address_two: address_two}
  end

  def apply(%Location{} = location, %LocationAddressCityChanged{address_city: address_city}) do
    %Location{location | address_city: address_city}
  end

  def apply(%Location{} = location, %LocationAddressCountryChanged{address_country: address_country}) do
    %Location{location | address_country: address_country}
  end

  def apply(%Location{} = location, %LocationAddressStateChanged{address_state: address_state}) do
    %Location{location | address_state: address_state}
  end

  def apply(%Location{} = location, %LocationAddressZipChanged{address_zip: address_zip}) do
    %Location{location | address_zip: address_zip}
  end

  # private helpers

  defp name_changed(%Location{}, %UpdateLocation{name: ""}), do: nil
  defp name_changed(%Location{name: name}, %UpdateLocation{name: name}), do: nil
  defp name_changed(%Location{uuid: location_uuid}, %UpdateLocation{name: name}) do
    %LocationNameChanged{
      location_uuid: location_uuid,
      name: name,
    }
  end

  defp description_changed(%Location{}, %UpdateLocation{description: ""}), do: nil
  defp description_changed(%Location{description: description}, %UpdateLocation{description: description}), do: nil
  defp description_changed(%Location{uuid: location_uuid}, %UpdateLocation{description: description}) do
    %LocationDescriptionChanged{
      location_uuid: location_uuid,
      description: description,
    }
  end

  defp address_one_changed(%Location{}, %UpdateLocation{address_one: ""}), do: nil
  defp address_one_changed(%Location{address_one: address_one}, %UpdateLocation{address_one: address_one}), do: nil
  defp address_one_changed(%Location{uuid: location_uuid}, %UpdateLocation{address_one: address_one}) do
    %LocationAddressOneChanged{
      location_uuid: location_uuid,
      address_one: address_one,
    }
  end

  defp address_two_changed(%Location{}, %UpdateLocation{address_two: ""}), do: nil
  defp address_two_changed(%Location{address_two: address_two}, %UpdateLocation{address_two: address_two}), do: nil
  defp address_two_changed(%Location{uuid: location_uuid}, %UpdateLocation{address_two: address_two}) do
    %LocationAddressTwoChanged{
      location_uuid: location_uuid,
      address_two: address_two,
    }
  end

  defp address_city_changed(%Location{}, %UpdateLocation{address_city: ""}), do: nil
  defp address_city_changed(%Location{address_city: address_city}, %UpdateLocation{address_city: address_city}), do: nil
  defp address_city_changed(%Location{uuid: location_uuid}, %UpdateLocation{address_city: address_city}) do
    %LocationAddressCityChanged{
      location_uuid: location_uuid,
      address_city: address_city,
    }
  end

  defp address_country_changed(%Location{}, %UpdateLocation{address_country: ""}), do: nil
  defp address_country_changed(%Location{address_country: address_country}, %UpdateLocation{address_country: address_country}), do: nil
  defp address_country_changed(%Location{uuid: location_uuid}, %UpdateLocation{address_country: address_country}) do
    %LocationAddressCountryChanged{
      location_uuid: location_uuid,
      address_country: address_country,
    }
  end

  defp address_state_changed(%Location{}, %UpdateLocation{address_state: ""}), do: nil
  defp address_state_changed(%Location{address_state: address_state}, %UpdateLocation{address_state: address_state}), do: nil
  defp address_state_changed(%Location{uuid: location_uuid}, %UpdateLocation{address_state: address_state}) do
    %LocationAddressStateChanged{
      location_uuid: location_uuid,
      address_state: address_state,
    }
  end

  defp address_zip_changed(%Location{}, %UpdateLocation{address_zip: ""}), do: nil
  defp address_zip_changed(%Location{address_zip: address_zip}, %UpdateLocation{address_zip: address_zip}), do: nil
  defp address_zip_changed(%Location{uuid: location_uuid}, %UpdateLocation{address_zip: address_zip}) do
    %LocationAddressZipChanged{
      location_uuid: location_uuid,
      address_zip: address_zip,
    }
  end
end
