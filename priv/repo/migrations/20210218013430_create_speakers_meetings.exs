defmodule OhioElixir.Repo.Migrations.CreateSpeakersMeetings do
  use Ecto.Migration

  def change do
    create table(:speakers_meetings) do
      add :speaker_id, references(:speakers)
      add :meeting_id, references(:meetings)
    end

    create unique_index(:speakers_meetings, [:speaker_id, :meeting_id])
  end
end
