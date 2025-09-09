defmodule OhioElixirWeb.PageController do
  use OhioElixirWeb, :controller

  alias OhioElixir.Events

  def index(conn, _params) do
    meeting = Events.get_active_meeting() |> OhioElixir.Repo.preload(:speakers)
    render(conn, "index.html", meeting: meeting)
  end

  def home(conn, _params) do
    conn
    |> put_root_layout(false)
    |> put_layout(false)
    |> render("home.html")
  end
end
