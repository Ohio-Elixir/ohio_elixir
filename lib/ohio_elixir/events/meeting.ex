defmodule OhioElixir.Events.Meeting do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "meetings" do
    field :date, :utc_datetime
    field :title, :string
    field :active, :boolean, default: false
    field :event_brite_id, :integer

    many_to_many :speakers, OhioElixir.Events.Speaker,
      join_through: "speakers_meetings",
      on_replace: :delete,
      on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(meeting, attrs) do
    meeting
    |> cast(attrs, [:date, :title, :event_brite_id])
    |> validate_required([:date, :title, :event_brite_id])
  end

  def change_active(meeting, active) do
    meeting
    |> cast(%{active: active}, [:active])
  end
end
