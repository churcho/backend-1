defmodule Core.Scheduler do
  @moduledoc """
  Handle Schedules
  """
  alias Core.DB.Job
  alias Core.Repo
  use Quantum.Scheduler,
    otp_app: :core

  alias Core.Scheduler
  alias Core.Scheduler.Queries.JobByName
  alias Crontab.CronExpression.Parser
  require Logger

  def schedule(job) do
    {:ok, cron} = Parser.parse(job.cron_string)

    if Scheduler.find_job(job.name) == nil do
      Scheduler.new_job()
      |> Quantum.Job.set_name(job.name)
      |> Quantum.Job.set_timezone(job.time_zone)
      |> Quantum.Job.set_schedule(cron)
      |> Quantum.Job.set_task(fn -> Code.eval_string(job.command_string) end)
      |> Core.Scheduler.add_job()
    end
  end

  @spec list_created_jobs() :: any()
  def list_created_jobs() do
    Repo.all(Job)
  end

  @doc """
  Create a new Job.
  """
  def create_job(attrs \\ %{}) do
    %Job{}
    |> Job.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a given job
  """
  def update_job(%Job{} = job, attrs \\ %{}) do
    job
    |> Job.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Get a job by name
  """
  def find_job_by_name(job_name) do
    job_name
    |> JobByName.new()
    |> Repo.one()
  end


  def create_or_update_job(job) do
    IO.puts "Creating JOB!"
    existing = Scheduler.find_job_by_name(job.name)
    if  existing == nil do
      IO.puts "no job exists"
      with {:ok, %Job{} = job} <-
        Scheduler.create_job(job)
      do
        Logger.info fn ->
          "Job created as #{job.name}"
        end
      end
    else
      IO.puts "Job exists"
      with {:ok, %Job{} = job} <-
        Scheduler.update_job(existing, job)
      do
        Logger.info fn ->
          "#{job.name} updated job"
        end
      end
    end
  end
end
