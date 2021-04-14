defmodule OhioElixir.EventsTest do
  use OhioElixir.DataCase
  import OhioElixir.EventsFixture

  alias OhioElixir.Events

  describe "meetings" do
    alias OhioElixir.Events.Meeting

    @valid_attrs %{date: "2010-04-17T14:00:00Z", title: "some title"}
    @update_attrs %{date: "2011-05-18T15:01:01Z", title: "some updated title"}
    @invalid_attrs %{date: nil, title: nil}

    test "list_meetings/0 returns all meetings" do
      meeting = meeting_fixture()
      assert Events.list_meetings() == [meeting]
    end

    test "get_meeting!/1 returns the meeting with given id" do
      meeting = meeting_fixture()
      assert Events.get_meeting!(meeting.id) == meeting
    end

    test "get_active_meeting/0 returns an active meeting" do
      active_meeting = meeting_fixture(%{active: true})
      _inactive_meeting = meeting_fixture(%{active: false})

      assert Events.get_active_meeting() == active_meeting
    end

    test "get_active_meeting/0 returns nil if one does not exist" do
      _inactive_meeting = meeting_fixture(%{active: false})

      refute Events.get_active_meeting()
    end

    test "create_meeting/1 with valid data creates a meeting" do
      assert {:ok, %Meeting{} = meeting} = Events.create_meeting(@valid_attrs)
      assert meeting.date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert meeting.title == "some title"
    end

    test "create_meeting/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_meeting(@invalid_attrs)
    end

    test "update_meeting/2 with valid data updates the meeting" do
      meeting = meeting_fixture()
      assert {:ok, %Meeting{} = meeting} = Events.update_meeting(meeting, @update_attrs)
      assert meeting.date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert meeting.title == "some updated title"
    end

    test "update_meeting/2 with invalid data returns error changeset" do
      meeting = meeting_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_meeting(meeting, @invalid_attrs)
      assert meeting == Events.get_meeting!(meeting.id)
    end

    test "update_active_status/2 updates a meeting to active" do
      meeting = meeting_fixture()
      assert {:ok, %Meeting{} = meeting} = Events.update_active_status(meeting, true)
      assert meeting.active
    end

    test "update_active_status/2 deactivates the existing active meeting" do
      active_meeting = meeting_fixture(%{active: true})
      meeting = meeting_fixture()
      assert {:ok, %Meeting{} = meeting} = Events.update_active_status(meeting, true)
      assert meeting.active
      refute reload(active_meeting).active
    end

    test "update_active_status/2 deactivates a meeting" do
      active_meeting = meeting_fixture(%{active: true})
      assert {:ok, %Meeting{} = meeting} = Events.update_active_status(active_meeting, false)
      refute meeting.active
    end

    test "add_speaker_to_meeting/2 with valid data associates the given speaker and meeting" do
      meeting = meeting_fixture() |> OhioElixir.Repo.preload(:speakers)
      speaker = speaker_fixture()

      assert {:ok, %Meeting{speakers: [^speaker]}} =
               Events.add_speaker_to_meeting(meeting, speaker)
    end

    test "add_speaker_to_meeting/2 given a speaker and meeting already associated returns meeting" do
      meeting = meeting_fixture() |> OhioElixir.Repo.preload(:speakers)
      speaker = speaker_fixture()

      assert {:ok, %Meeting{speakers: [^speaker]} = meeting} =
               Events.add_speaker_to_meeting(meeting, speaker)

      assert {:ok, %Meeting{speakers: [^speaker]}} =
               Events.add_speaker_to_meeting(meeting, speaker)
    end

    test "remove_speaker_from_meeting/2 given a speaker and meeting removes the association" do
      meeting = meeting_fixture() |> OhioElixir.Repo.preload(:speakers)
      speaker = speaker_fixture()

      assert {:ok, %Meeting{speakers: [^speaker]} = meeting} =
               Events.add_speaker_to_meeting(meeting, speaker)

      assert {:ok, %Meeting{speakers: []}} = Events.remove_speaker_from_meeting(meeting, speaker)
    end

    test "remove_speaker_from_meeting/2 given a speaker and meeting not associated returns meeting" do
      meeting = meeting_fixture() |> OhioElixir.Repo.preload(:speakers)
      speaker = speaker_fixture()

      assert {:ok, %Meeting{speakers: []}} = Events.remove_speaker_from_meeting(meeting, speaker)
    end

    test "delete_meeting/1 deletes the meeting" do
      meeting = meeting_fixture()
      assert {:ok, %Meeting{}} = Events.delete_meeting(meeting)
      assert_raise Ecto.NoResultsError, fn -> Events.get_meeting!(meeting.id) end
    end

    test "change_meeting/1 returns a meeting changeset" do
      meeting = meeting_fixture()
      assert %Ecto.Changeset{} = Events.change_meeting(meeting)
    end
  end

  describe "speakers" do
    alias OhioElixir.Events.Speaker

    @valid_attrs %{
      github_url: "some github_url",
      name: "some name",
      twitter_url: "some twitter_url"
    }
    @update_attrs %{
      github_url: "some updated github_url",
      name: "some updated name",
      twitter_url: "some updated twitter_url"
    }
    @invalid_attrs %{github_url: nil, name: nil, twitter_url: nil}

    test "list_speakers/0 returns all speakers" do
      speaker = speaker_fixture()
      assert Events.list_speakers() == [speaker]
    end

    test "get_speaker!/1 returns the speaker with given id" do
      speaker = speaker_fixture()
      assert Events.get_speaker!(speaker.id) == speaker
    end

    test "create_speaker/1 with valid data creates a speaker" do
      assert {:ok, %Speaker{} = speaker} = Events.create_speaker(@valid_attrs)
      assert speaker.github_url == "some github_url"
      assert speaker.name == "some name"
      assert speaker.twitter_url == "some twitter_url"
    end

    test "create_speaker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_speaker(@invalid_attrs)
    end

    test "update_speaker/2 with valid data updates the speaker" do
      speaker = speaker_fixture()
      assert {:ok, %Speaker{} = speaker} = Events.update_speaker(speaker, @update_attrs)
      assert speaker.github_url == "some updated github_url"
      assert speaker.name == "some updated name"
      assert speaker.twitter_url == "some updated twitter_url"
    end

    test "update_speaker/2 with invalid data returns error changeset" do
      speaker = speaker_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_speaker(speaker, @invalid_attrs)
      assert speaker == Events.get_speaker!(speaker.id)
    end

    test "delete_speaker/1 deletes the speaker" do
      speaker = speaker_fixture()
      assert {:ok, %Speaker{}} = Events.delete_speaker(speaker)
      assert_raise Ecto.NoResultsError, fn -> Events.get_speaker!(speaker.id) end
    end

    test "change_speaker/1 returns a speaker changeset" do
      speaker = speaker_fixture()
      assert %Ecto.Changeset{} = Events.change_speaker(speaker)
    end
  end
end
