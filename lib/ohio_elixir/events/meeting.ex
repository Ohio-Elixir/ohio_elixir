defmodule OhioElixir.Events.Meeting do
  use Ecto.Schema
  import Ecto.Changeset

  schema "meetings" do
    field :date, :utc_datetime
    field :title, :string
    field :active, :boolean, default: false

    many_to_many :speakers, OhioElixir.Events.Speaker,
      join_through: "speakers_meetings",
      on_replace: :delete,
      on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(meeting, attrs) do
    meeting
    |> cast(attrs, [:date, :title])
    |> validate_required([:date, :title])
  end

  def change_active(meeting, active) do
    meeting
    |> cast(%{active: active}, [:active])
  end
end
