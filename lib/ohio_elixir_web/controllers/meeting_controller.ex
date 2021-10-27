defmodule OhioElixirWeb.MeetingController do
  use OhioElixirWeb, :controller

  alias OhioElixir.Events
  alias OhioElixir.Events.Meeting

  def index(conn, _params) do
    meetings = Events.list_meetings()
    render(conn, "index.html", meetings: meetings)
  end

  def new(conn, _params) do
    changeset = Events.change_meeting(%Meeting{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"meeting" => meeting_params}) do
    case Events.create_meeting(meeting_params) do
      {:ok, meeting} ->
        conn
        |> put_flash(:info, "Meeting created successfully.")
        |> redirect(to: Routes.meeting_path(conn, :show, meeting))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    meeting = Events.get_meeting!(id) |> OhioElixir.Repo.preload(:speakers)
    changeset = Events.change_meeting(meeting)
    speakers = Events.list_speakers()
    render(conn, "show.html", meeting: meeting, changeset: changeset, speakers: speakers)
  end

  def edit(conn, %{"id" => id}) do
    meeting = id |> Events.get_meeting!() |> date_to_naive()
    changeset = Events.change_meeting(meeting)
    render(conn, "edit.html", meeting: meeting, changeset: changeset)
  end

  def update(conn, %{"id" => meeting_id, "meeting" => %{"speaker_id" => speaker_id}}) do
    meeting = Events.get_meeting!(meeting_id) |> OhioElixir.Repo.preload(:speakers)
    speaker = Events.get_speaker!(speaker_id)

    case Events.add_speaker_to_meeting(meeting, speaker) do
      {:ok, meeting} ->
        conn
        |> put_flash(:info, "Speaker added successfully.")
        |> redirect(to: Routes.meeting_path(conn, :show, meeting))

      {:error, %Ecto.Changeset{}} ->
        conn
        |> put_flash(:error, "Could not add speaker.")
        |> redirect(to: Routes.meeting_path(conn, :show, meeting))
    end
  end

  def update(conn, %{"id" => id, "meeting" => meeting_params}) do
    meeting = Events.get_meeting!(id)

    case Events.update_meeting(meeting, meeting_params) do
      {:ok, meeting} ->
        conn
        |> put_flash(:info, "Meeting updated successfully.")
        |> redirect(to: Routes.meeting_path(conn, :show, meeting))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", meeting: meeting, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => meeting_id, "speaker_id" => speaker_id}) do
    meeting = Events.get_meeting!(meeting_id) |> OhioElixir.Repo.preload(:speakers)
    speaker = Events.get_speaker!(speaker_id)

    case Events.remove_speaker_from_meeting(meeting, speaker) do
      {:ok, meeting} ->
        conn
        |> put_flash(:info, "Speaker removed successfully.")
        |> redirect(to: Routes.meeting_path(conn, :show, meeting))

      {:error, %Ecto.Changeset{}} ->
        conn
        |> put_flash(:error, "Could not add speaker.")
        |> redirect(to: Routes.meeting_path(conn, :show, meeting))
    end
  end

  def delete(conn, %{"id" => id}) do
    meeting = Events.get_meeting!(id)
    {:ok, _meeting} = Events.delete_meeting(meeting)

    conn
    |> put_flash(:info, "Meeting deleted successfully.")
    |> redirect(to: Routes.meeting_path(conn, :index))
  end

  defp date_to_naive(meeting) do
    %{meeting | date: DateTime.to_naive(meeting.date)}
  end
end
