defmodule OhioElixir.Repo.Migrations.CreateMeetings do
  use Ecto.Migration

  def change do
    create table(:meetings) do
      add :date, :utc_datetime
      add :title, :string

      timestamps()
    end
  end
end
