defmodule OhioElixir.EventsFixture do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OhioElixir.Events` context.
  """

  alias OhioElixir.Events

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
    valid_attrs = %{date: "2010-04-17T14:00:00Z", title: "some title"}

    {:ok, meeting} =
      attrs
      |> Enum.into(valid_attrs)
      |> Events.create_meeting()

    meeting
  end
end
