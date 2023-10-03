defmodule OhioElixirWeb.SpeakerController do
  use OhioElixirWeb, :controller

  alias OhioElixir.Events
  alias OhioElixir.Events.Speaker

  def index(conn, _params) do
    speakers = Events.list_speakers()
    render(conn, "index.html", speakers: speakers)
  end

  def new(conn, _params) do
    changeset = Events.change_speaker(%Speaker{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"speaker" => speaker_params}) do
    case Events.create_speaker(speaker_params) do
      {:ok, speaker} ->
        conn
        |> put_flash(:info, "Speaker created successfully.")
        |> redirect(to: ~p"/speakers/#{speaker}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    speaker = Events.get_speaker!(id)
    render(conn, "show.html", speaker: speaker)
  end

  def edit(conn, %{"id" => id}) do
    speaker = Events.get_speaker!(id)
    changeset = Events.change_speaker(speaker)
    render(conn, "edit.html", speaker: speaker, changeset: changeset)
  end

  def update(conn, %{"id" => id, "speaker" => speaker_params}) do
    speaker = Events.get_speaker!(id)

    case Events.update_speaker(speaker, speaker_params) do
      {:ok, speaker} ->
        conn
        |> put_flash(:info, "Speaker updated successfully.")
        |> redirect(to: ~p"/speakers/#{speaker}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", speaker: speaker, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    speaker = Events.get_speaker!(id)
    {:ok, _speaker} = Events.delete_speaker(speaker)

    conn
    |> put_flash(:info, "Speaker deleted successfully.")
    |> redirect(to: ~p"/speakers")
  end
end
