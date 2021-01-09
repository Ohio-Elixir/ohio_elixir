defmodule OhioElixir.Repo do
  use Ecto.Repo,
    otp_app: :ohio_elixir,
    adapter: Ecto.Adapters.Postgres
end
