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

alias OhioElixir.Accounts
alias OhioElixir.Repo
alias OhioElixir.Events
alias OhioElixir.Events.Meeting
alias OhioElixir.Events.Speaker

meeting_one =
  Repo.insert!(%Meeting{
    title: "A really neat LiveView talk",
    date: DateTime.utc_now() |> DateTime.truncate(:second),
    event_brite_id: 1_234_567_890
  })
  |> Repo.preload(:speakers)

meeting_two =
  Repo.insert!(%Meeting{
    active: true,
    title: "The coolest Nerves presentation",
    date:
      DateTime.utc_now()
      |> DateTime.add(86_400 * 30, :second)
      |> DateTime.truncate(:second),
    event_brite_id: 2_234_567_890
  })
  |> Repo.preload(:speakers)

speaker_one =
  Repo.insert!(%Speaker{
    name: "Jane Doe",
    social_link: "https:/github.com/janedoe"
  })

speaker_two =
  Repo.insert!(%Speaker{
    name: "John Doe",
    social_link: "https:/github.com/janedoe"
  })

Events.add_speaker_to_meeting(meeting_one, speaker_one)
Events.add_speaker_to_meeting(meeting_two, speaker_two)

# User Creation
Accounts.register_user(%{email: "user@example.com", password: "supersecretpassword"})
