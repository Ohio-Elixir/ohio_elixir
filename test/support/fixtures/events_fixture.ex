defmodule OhioElixir.EventsFixture do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OhioElixir.Events` context.
  """

  alias OhioElixir.Events
  alias OhioElixir.Events.Meeting
  alias OhioElixir.Repo

  def speaker_fixture(attrs \\ %{}) do
    valid_attrs = %{
      github_url: "some github_url",
      name: "some name",
      twitter_url: "some twitter_url"
    }

    {:ok, speaker} =
      attrs
      |> Enum.into(valid_attrs)
      |> Events.create_speaker()

    speaker
  end

  def meeting_fixture(attrs \\ %{}) do
    valid_attrs = %{date: "2010-04-17T14:00:00Z", title: "some title", event_brite_id: 12_345}

    attrs = Enum.into(attrs, valid_attrs)

    {:ok, meeting} =
      %Meeting{}
      |> Meeting.changeset(attrs)
      |> Meeting.change_active(attrs[:active])
      |> Repo.insert()

    meeting
  end
end
