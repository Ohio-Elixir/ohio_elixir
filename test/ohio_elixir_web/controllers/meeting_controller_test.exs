defmodule OhioElixirWeb.MeetingControllerTest do
  use OhioElixirWeb.ConnCase
  import OhioElixir.EventsFixture

  alias OhioElixir.Events

  @create_attrs %{date: "2010-04-17T14:00:00Z", title: "some title"}
  @update_attrs %{date: "2011-05-18T15:01:01Z", title: "some updated title"}
  @invalid_attrs %{date: nil, title: nil}

  setup :register_and_log_in_user

  describe "index" do
    test "lists all meetings", %{conn: conn} do
      conn = get(conn, Routes.meeting_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Meetings"
    end
  end

  describe "new meeting" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.meeting_path(conn, :new))
      assert html_response(conn, 200) =~ "New Meeting"
    end
  end

  describe "create meeting" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.meeting_path(conn, :create), meeting: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.meeting_path(conn, :show, id)

      conn = get(conn, Routes.meeting_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Meeting"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.meeting_path(conn, :create), meeting: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Meeting"
    end
  end

  describe "edit meeting" do
    setup [:create_meeting]

    test "renders form for editing chosen meeting", %{conn: conn, meeting: meeting} do
      conn = get(conn, Routes.meeting_path(conn, :edit, meeting))
      assert html_response(conn, 200) =~ "Edit Meeting"
    end
  end

  describe "update meeting" do
    setup [:create_meeting, :create_speaker]

    test "redirects when data is valid", %{conn: conn, meeting: meeting} do
      conn = put(conn, Routes.meeting_path(conn, :update, meeting), meeting: @update_attrs)
      assert redirected_to(conn) == Routes.meeting_path(conn, :show, meeting)

      conn = get(conn, Routes.meeting_path(conn, :show, meeting))
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "redirects and adds relationship when speaker provided", %{
      conn: conn,
      meeting: meeting,
      speaker: speaker
    } do
      conn =
        put(conn, Routes.meeting_path(conn, :update, meeting), meeting: %{speaker_id: speaker.id})

      assert redirected_to(conn) == Routes.meeting_path(conn, :show, meeting)

      conn = get(conn, Routes.meeting_path(conn, :show, meeting))
      assert html_response(conn, 200) =~ speaker.name
    end

    test "renders errors when data is invalid", %{conn: conn, meeting: meeting} do
      conn = put(conn, Routes.meeting_path(conn, :update, meeting), meeting: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Meeting"
    end
  end

  describe "delete meeting" do
    setup [:create_meeting, :create_speaker]

    test "deletes chosen meeting", %{conn: conn, meeting: meeting} do
      conn = delete(conn, Routes.meeting_path(conn, :delete, meeting))
      assert redirected_to(conn) == Routes.meeting_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.meeting_path(conn, :show, meeting))
      end
    end

    test "deletes speaker from meeting", %{conn: conn, meeting: meeting, speaker: speaker} do
      meeting = OhioElixir.Repo.preload(meeting, :speakers)

      Events.add_speaker_to_meeting(meeting, speaker)

      conn = delete(conn, Routes.meeting_path(conn, :delete, meeting, speaker_id: speaker.id))
      assert redirected_to(conn) == Routes.meeting_path(conn, :show, meeting)

      conn = get(conn, Routes.meeting_path(conn, :show, meeting))
      assert html_response(conn, 200) =~ "Speaker removed successfully."
    end
  end

  defp create_meeting(_) do
    %{meeting: meeting_fixture()}
  end

  defp create_speaker(_) do
    %{speaker: speaker_fixture()}
  end
end
