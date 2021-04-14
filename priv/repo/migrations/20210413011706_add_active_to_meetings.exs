defmodule OhioElixir.Repo.Migrations.AddActiveToMeetings do
  use Ecto.Migration

  def change do
    alter table(:meetings) do
      add :active, :boolean, default: false
    end
  end
end
