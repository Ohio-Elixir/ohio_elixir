defmodule OhioElixirWeb.ActivationControllerTest do
  use OhioElixirWeb.ConnCase
  import OhioElixir.EventsFixture

  setup :register_and_log_in_user

  describe "create/2" do
    setup [:create_meeting]

    test "redirects to index when data is valid", %{conn: conn, meeting: meeting} do
      conn = post(conn, Routes.meeting_activation_path(conn, :create, meeting), active: "true")

      assert redirected_to(conn) == Routes.meeting_path(conn, :index)
      assert get_flash(conn, :info) == "Active status updated"
    end
  end

  defp create_meeting(_) do
    %{meeting: meeting_fixture()}
  end
end
