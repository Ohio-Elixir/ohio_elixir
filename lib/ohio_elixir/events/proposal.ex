defmodule OhioElixir.Events.Proposal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "proposals" do
    field :desired_month, :string
    field :speaker_email, :string
    field :speaker_name, :string
    field :summary, :string

    timestamps()
  end

  @doc false
  def changeset(proposal, attrs) do
    proposal
    |> cast(attrs, [:speaker_name, :speaker_email, :summary, :desired_month])
    |> validate_required([:speaker_name, :speaker_email, :summary, :desired_month])
  end
end
