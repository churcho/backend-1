defmodule Core.Places.Workflows.ScheduleSunriseSunsetUpdate do
  @moduledoc false
  import Crontab.CronExpression

  def handle_schedule() do
    schedule()
    :ok
  end

  def handle_broadcast(event) do
    CoreWeb.EventChannel.broadcast_change("location_weather_updated", event)
    :ok
  end

  def schedule() do
    if Core.Scheduler.find_job(:sunrise) == nil do
      Core.Scheduler.new_job()
      |> Quantum.Job.set_name(:sunrise)
      |> Quantum.Job.set_timezone("America/Los_Angeles")
      |> Quantum.Job.set_schedule(~e[0 0 * * *])
      |> Quantum.Job.set_task(fn -> Core.Places.update_sunrise_and_sunset() end)
      |> Core.Scheduler.add_job()
    end
  end
end
