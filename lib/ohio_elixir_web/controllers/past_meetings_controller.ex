defmodule OhioElixirWeb.PastMeetingsController do
  use OhioElixirWeb, :controller

  alias OhioElixir.Events

  def index(conn, _params) do
    meetings = Events.list_past_meetings() |> OhioElixir.Repo.preload(:speakers)
    render(conn, "index.html", meetings: meetings)
  end
end
