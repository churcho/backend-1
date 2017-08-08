defmodule Huebris.Client do
  @moduledoc false

  @doc """
  Connect to a bridge
  """
  def connect(host, api_key) do
    Exhue.connect(host, api_key)
  end

  @doc """
  Get the lights payload
  """
  def getlights(bridge)  do
    Exhue.Lights.list(bridge.host, bridge.username)
  end


  def turn_on(ip, token, id, level) do
    Exhue.Lights.turn_on(ip, token, id, level)
  end

  def turn_off(ip, token, id) do
    Exhue.Lights.turn_off(ip, token, id)
  end

  def set_level(ip, token, id, level) do
    Exhue.Lights.set_level(ip, token, id, set_brightness(level))
  end

  def set_color(ip, token, id, color) do

    new_color = Exhue.Colors.color_to_xy(color)

    IO.inspect new_color


    Exhue.Lights.set_color(ip, token, id, new_color)
  end

  def get_brightness(bri) do
    if bri do
      round(bri / 254 * 100)
    else
      0
    end
  end

  def set_brightness(bri) do
     if bri do
       round(bri * 254 / 100)
     else
       254
     end
  end

  def get_colors_in_rgb(xy, bri) do
    if xy do
      [x,y] = xy
      if x > 0 && y > 0 do
        colors = Exhue.Colors.xy_to_color(xy, bri)
        IO.puts "Color Conversion"
        [colors.r, colors.g, colors.b]
      else
        []
      end
    else
      IO.puts "No color"
      []
    end
  end

  def convert_bools(bool) do
  	case bool do
  		true ->
  			"on"
  		false ->
  			"off"
  		_ ->
  			"Unknow"
   	end
  end
end
