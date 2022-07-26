defmodule OhioElixir.EventsTest do
  use OhioElixir.DataCase
  import OhioElixir.EventsFixture

  alias OhioElixir.Events

  describe "meetings" do
    alias OhioElixir.Events.Meeting

    @valid_attrs %{date: "2010-04-17T14:00:00Z", title: "some title", event_brite_id: 12_345}
    @update_attrs %{date: "2011-05-18T15:01:01Z", title: "some updated title"}
    @invalid_attrs %{date: nil, title: nil}

    test "list_meetings/0 returns all meetings" do
      meeting = meeting_fixture()
      assert Events.list_meetings() == [meeting]
    end

    test "list_past_meetings/0 only returns meetings from the past" do
      _future_meeting = meeting_fixture(%{date: DateTime.add(DateTime.utc_now(), 3600)})
      past_meeting_one = meeting_fixture(%{date: "2021-04-17T14:00:00Z"})
      past_meeting_two = meeting_fixture(%{date: "2021-03-17T14:00:00Z"})
      assert Events.list_past_meetings() == [past_meeting_one, past_meeting_two]
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
      name: "some name",
      social_link: "some twitter_url"
    }
    @update_attrs %{
      name: "some updated name",
      social_link: "some updated twitter_url"
    }
    @invalid_attrs %{name: nil, social_link: nil}

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
      assert speaker.name == "some name"
      assert speaker.social_link == "some twitter_url"
    end

    test "create_speaker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_speaker(@invalid_attrs)
    end

    test "update_speaker/2 with valid data updates the speaker" do
      speaker = speaker_fixture()
      assert {:ok, %Speaker{} = speaker} = Events.update_speaker(speaker, @update_attrs)
      assert speaker.name == "some updated name"
      assert speaker.social_link == "some updated twitter_url"
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

  describe "proposals" do
    alias OhioElixir.Events.Proposal

    import OhioElixir.EventsFixtures

    @invalid_attrs %{desired_month: nil, speaker_email: nil, speaker_name: nil, summary: nil}

    test "list_proposals/0 returns all proposals" do
      proposal = proposal_fixture()
      assert Events.list_proposals() == [proposal]
    end

    test "get_proposal!/1 returns the proposal with given id" do
      proposal = proposal_fixture()
      assert Events.get_proposal!(proposal.id) == proposal
    end

    test "create_proposal/1 with valid data creates a proposal" do
      valid_attrs = %{
        desired_month: "some desired_month",
        speaker_email: "some speaker_email",
        speaker_name: "some speaker_name",
        summary: "some summary"
      }

      assert {:ok, %Proposal{} = proposal} = Events.create_proposal(valid_attrs)
      assert proposal.desired_month == "some desired_month"
      assert proposal.speaker_email == "some speaker_email"
      assert proposal.speaker_name == "some speaker_name"
      assert proposal.summary == "some summary"
    end

    test "create_proposal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_proposal(@invalid_attrs)
    end

    test "update_proposal/2 with valid data updates the proposal" do
      proposal = proposal_fixture()

      update_attrs = %{
        desired_month: "some updated desired_month",
        speaker_email: "some updated speaker_email",
        speaker_name: "some updated speaker_name",
        summary: "some updated summary"
      }

      assert {:ok, %Proposal{} = proposal} = Events.update_proposal(proposal, update_attrs)
      assert proposal.desired_month == "some updated desired_month"
      assert proposal.speaker_email == "some updated speaker_email"
      assert proposal.speaker_name == "some updated speaker_name"
      assert proposal.summary == "some updated summary"
    end

    test "update_proposal/2 with invalid data returns error changeset" do
      proposal = proposal_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_proposal(proposal, @invalid_attrs)
      assert proposal == Events.get_proposal!(proposal.id)
    end

    test "delete_proposal/1 deletes the proposal" do
      proposal = proposal_fixture()
      assert {:ok, %Proposal{}} = Events.delete_proposal(proposal)
      assert_raise Ecto.NoResultsError, fn -> Events.get_proposal!(proposal.id) end
    end

    test "change_proposal/1 returns a proposal changeset" do
      proposal = proposal_fixture()
      assert %Ecto.Changeset{} = Events.change_proposal(proposal)
    end
  end
end
