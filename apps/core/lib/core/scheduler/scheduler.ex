defmodule Core.Scheduler do
  @moduledoc false
  use Quantum.Scheduler,
    otp_app: :core

  alias Core.Scheduler
  alias Crontab.CronExpression.Parser

  def schedule(job) do

    {:ok, cron} = Parser.parse(job.cron_string)

    if Scheduler.find_job(job.name) == nil do
      Scheduler.new_job()
      |> Quantum.Job.set_name(job.name)
      |> Quantum.Job.set_timezone(job.time_zone)
      |> Quantum.Job.set_schedule(cron)
      |> Quantum.Job.set_task(fn -> Code.eval_string(job.function_string) end)
      |> Core.Scheduler.add_job()
    end
  end
end
