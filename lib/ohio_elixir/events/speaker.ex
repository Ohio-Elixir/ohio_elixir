defmodule OhioElixir.Events.Speaker do
  use Ecto.Schema
  import Ecto.Changeset

  schema "speakers" do
    field :github_url, :string
    field :name, :string
    field :twitter_url, :string

    many_to_many :meetings, OhioElixir.Events.Meeting,
      join_through: "speakers_meetings",
      on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(speaker, attrs) do
    speaker
    |> cast(attrs, [:name, :twitter_url, :github_url])
    |> validate_required([:name])
  end
end
