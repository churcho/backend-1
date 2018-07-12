defmodule Core.Ability do
  @moduledoc false
  alias Core.Ability.Sensors.{
    Temperature,
    RelativeHumidity
  }


  def list do
    %{
      sensors: [
        %Temperature{},
        %RelativeHumidity{}
      ]
    }
  end

end
