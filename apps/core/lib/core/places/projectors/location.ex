defmodule Core.Places.Projectors.Location do
  @moduledoc false
  use Commanded.Projections.Ecto,
    name: "Places.Projectors.Location",
    consistency: :strong

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
    LocationAddressZipChanged,

  }
  alias Core.Places.Projections.Location
  alias Ecto.Multi

  project %LocationCreated{} = created do
    Multi.insert(multi, :location, %Location{
      uuid: created.location_uuid,
      name: created.name,
      description: created.description,
      address_one: created.address_one,
      address_two: created.address_two,
      address_city: created.address_city,
      address_country: created.address_country,
      address_state: created.address_state,
      address_zip: created.address_zip,
    })
  end

  project %LocationNameChanged{location_uuid: location_uuid, name: name} do
    update_location(multi, location_uuid, name: name)
  end

  project %LocationDescriptionChanged{
    location_uuid: location_uuid, description: description}
  do
    update_location(multi, location_uuid, description: description)
  end

  project %LocationAddressOneChanged{
    location_uuid: location_uuid, address_one: address_one}
  do
    update_location(multi, location_uuid, address_one: address_one)
  end

  project %LocationAddressTwoChanged{
    location_uuid: location_uuid, address_two: address_two}
  do
    update_location(multi, location_uuid, address_two: address_two)
  end

  project %LocationAddressCityChanged{
    location_uuid: location_uuid, address_city: address_city}
  do
    update_location(multi, location_uuid, address_city: address_city)
  end

  project %LocationAddressCountryChanged{
    location_uuid: location_uuid, address_country: address_country}
  do
    update_location(multi, location_uuid, address_country: address_country)
  end

  project %LocationAddressStateChanged{
    location_uuid: location_uuid, address_state: address_state}
  do
    update_location(multi, location_uuid, address_state: address_state)
  end

  project %LocationAddressZipChanged{
    location_uuid: location_uuid, address_zip: address_zip}
  do
    update_location(multi, location_uuid, address_zip: address_zip)
  end

  project %LocationDeleted{location_uuid: location_uuid} do
    Multi.delete_all(multi, :location, location_query(location_uuid))
  end

  defp update_location(multi, location_uuid, changes) do
    Multi.update_all(
      multi, :location, location_query(location_uuid), set: changes
      )
  end

  defp location_query(location_uuid) do
    from(l in Location, where: l.uuid == ^location_uuid)
  end
end
