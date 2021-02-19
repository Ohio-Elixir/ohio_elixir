defmodule OhioElixir.Repo.Migrations.CreateSpeakers do
  use Ecto.Migration

  def change do
    create table(:speakers) do
      add :name, :string
      add :twitter_url, :string
      add :github_url, :string

      timestamps()
    end
  end
end
