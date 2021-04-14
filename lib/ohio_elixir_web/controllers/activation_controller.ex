defmodule OhioElixirWeb.ActivationController do
  use OhioElixirWeb, :controller

  alias OhioElixir.Events

  def create(conn, %{"meeting_id" => meeting_id, "active" => active}) do
    meeting_id
    |> Events.get_meeting!()
    |> Events.update_active_status(String.to_existing_atom(active))
    |> case do
      {:ok, _meeting} ->
        conn
        |> put_flash(:info, "Active status updated")
        |> redirect(to: Routes.meeting_path(conn, :index))

      {:error, %Ecto.Changeset{}} ->
        conn
        |> put_flash(:error, "Could not update to active.")
        |> redirect(to: Routes.meeting_path(conn, :index))
    end
  end
end
