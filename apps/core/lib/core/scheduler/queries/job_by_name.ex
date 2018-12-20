defmodule Core.Scheduler.Queries.JobByName do
  @moduledoc false
  import Ecto.Query

  alias Core.DB.Job

  def new(job_name) do
    from j in Job,
    where: j.name == ^job_name
  end
end
