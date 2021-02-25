# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     OhioElixir.Repo.insert!(%OhioElixir.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias OhioElixir.Repo
alias OhioElixir.Events
alias OhioElixir.Events.Meeting
alias OhioElixir.Events.Speaker

meeting_one =
  Repo.insert!(%Meeting{
    title: "A really neat LiveView talk",
    date: DateTime.utc_now() |> DateTime.truncate(:second)
  })
  |> Repo.preload(:speakers)

meeting_two =
  Repo.insert!(%Meeting{
    title: "The coolest Nerves presentation",
    date: DateTime.utc_now() |> DateTime.truncate(:second)
  })
  |> Repo.preload(:speakers)

speaker_one =
  Repo.insert!(%Speaker{
    name: "Jane Doe",
    github_url: "github.com/janedoe",
    twitter_url: "twitter.com/janedoe"
  })

speaker_two =
  Repo.insert!(%Speaker{
    name: "John Doe",
    github_url: "github.com/johndoe",
    twitter_url: "twitter.com/johndoe"
  })

Events.add_speaker_to_meeting(meeting_one, speaker_one)
Events.add_speaker_to_meeting(meeting_two, speaker_two)
