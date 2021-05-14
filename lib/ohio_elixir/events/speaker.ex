defmodule OhioElixir.Events.Speaker do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "speakers" do
    field :name, :string
    field :social_link, :string

    many_to_many :meetings, OhioElixir.Events.Meeting,
      join_through: "speakers_meetings",
      on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(speaker, attrs) do
    speaker
    |> cast(attrs, [:name, :social_link])
    |> validate_required([:name])
  end
end
