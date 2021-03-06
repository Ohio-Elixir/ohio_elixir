defmodule OhioElixirWeb.SpeakerControllerTest do
  use OhioElixirWeb.ConnCase
  import OhioElixir.EventsFixture

  @create_attrs %{
    name: "some name",
    social_link: "some twitter_url"
  }
  @update_attrs %{
    name: "some updated name",
    social_link: "some updated twitter_url"
  }
  @invalid_attrs %{name: nil, social_link: nil}

  setup :register_and_log_in_user

  describe "index" do
    test "lists all speakers", %{conn: conn} do
      conn = get(conn, Routes.speaker_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Speakers"
    end
  end

  describe "new speaker" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.speaker_path(conn, :new))
      assert html_response(conn, 200) =~ "New Speaker"
    end
  end

  describe "create speaker" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.speaker_path(conn, :create), speaker: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.speaker_path(conn, :show, id)

      conn = get(conn, Routes.speaker_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Speaker"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.speaker_path(conn, :create), speaker: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Speaker"
    end
  end

  describe "edit speaker" do
    setup [:create_speaker]

    test "renders form for editing chosen speaker", %{conn: conn, speaker: speaker} do
      conn = get(conn, Routes.speaker_path(conn, :edit, speaker))
      assert html_response(conn, 200) =~ "Edit Speaker"
    end
  end

  describe "update speaker" do
    setup [:create_speaker]

    test "redirects when data is valid", %{conn: conn, speaker: speaker} do
      conn = put(conn, Routes.speaker_path(conn, :update, speaker), speaker: @update_attrs)
      assert redirected_to(conn) == Routes.speaker_path(conn, :show, speaker)

      conn = get(conn, Routes.speaker_path(conn, :show, speaker))
      assert html_response(conn, 200) =~ "some updated twitter_url"
    end

    test "renders errors when data is invalid", %{conn: conn, speaker: speaker} do
      conn = put(conn, Routes.speaker_path(conn, :update, speaker), speaker: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Speaker"
    end
  end

  describe "delete speaker" do
    setup [:create_speaker]

    test "deletes chosen speaker", %{conn: conn, speaker: speaker} do
      conn = delete(conn, Routes.speaker_path(conn, :delete, speaker))
      assert redirected_to(conn) == Routes.speaker_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.speaker_path(conn, :show, speaker))
      end
    end
  end

  defp create_speaker(_) do
    %{speaker: speaker_fixture()}
  end
end
