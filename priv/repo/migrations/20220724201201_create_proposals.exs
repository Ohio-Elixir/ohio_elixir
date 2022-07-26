defmodule OhioElixir.Repo.Migrations.CreateProposals do
  use Ecto.Migration

  def change do
    create table(:proposals) do
      add :speaker_name, :string
      add :speaker_email, :string
      add :summary, :text
      add :desired_month, :string

      timestamps()
    end
  end
end
