defmodule OhioElixir.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OhioElixir.Events` context.
  """

  @doc """
  Generate a proposal.
  """
  def proposal_fixture(attrs \\ %{}) do
    {:ok, proposal} =
      attrs
      |> Enum.into(%{
        desired_month: "some desired_month",
        speaker_email: "some speaker_email",
        speaker_name: "some speaker_name",
        summary: "some summary"
      })
      |> OhioElixir.Events.create_proposal()

    proposal
  end
end
