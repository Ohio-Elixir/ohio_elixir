defmodule OhioElixir.Repo.Migrations.AddEventBriteIdToMeetings do
  use Ecto.Migration

  def change do
    alter table(:meetings) do
      add :event_brite_id, :bigint
    end
  end
end
