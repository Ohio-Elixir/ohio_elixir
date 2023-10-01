defmodule OhioElixirWeb.PastMeetingsViewTest do
  use OhioElixirWeb.ConnCase, async: true
  import OhioElixir.EventsFixture

  alias OhioElixirWeb.PastMeetingsView, as: View

  setup [:create_speaker]

  @tag social_link: "test_url"
  test "links speaker name to social link when one is available", %{speaker: speaker} do
    assert View.speaker_link(speaker) ==
             {:safe, ~c"<a href=\"test_url\" target=\"_blank\">some name</a><br>"}
  end

  @tag social_link: nil
  test "returns speaker name if no social link is available", %{speaker: speaker} do
    assert View.speaker_link(speaker) == {:safe, ~c"some name<br>"}
  end

  defp create_speaker(ctx) do
    [speaker: speaker_fixture(%{social_link: ctx[:social_link]})]
  end
end
