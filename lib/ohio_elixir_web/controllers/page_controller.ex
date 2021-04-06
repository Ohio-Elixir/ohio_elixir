defmodule OhioElixirWeb.PageController do
  use OhioElixirWeb, :controller

  alias OhioElixir.Events

  def index(conn, _params) do
    # TODO: this needs to be the "active" meeting
    meeting = Events.list_meetings() |> List.last() |> OhioElixir.Repo.preload(:speakers)
    render(conn, "index.html", meeting: meeting)
  end
end
