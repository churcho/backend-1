defmodule Core.DataCase do
  @moduledoc false
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Core.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Core.Factory
      import Core.Fixture
      import Core.DataCase
    end
  end

  setup do
    Core.Storage.reset!()

    :ok
  end
end
