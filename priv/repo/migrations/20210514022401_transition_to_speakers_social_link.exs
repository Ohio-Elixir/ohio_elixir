defmodule OhioElixir.Repo.Migrations.TransitionToSpeakersSocialLink do
  use Ecto.Migration

  def change do
    alter table("speakers") do
      remove :github_url
      remove :twitter_url
      add :social_link, :string
    end
  end
end
