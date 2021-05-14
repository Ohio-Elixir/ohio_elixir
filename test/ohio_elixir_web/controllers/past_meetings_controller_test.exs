defmodule OhioElixirWeb.PastMeetingsControllerTest do
  use OhioElixirWeb.ConnCase

  describe "index" do
    test "lists past meetings", %{conn: conn} do
      conn = get(conn, Routes.past_meetings_path(conn, :index))
      assert html_response(conn, 200) =~ "Past Meetings"
    end
  end
end
