defmodule OhioElixir.DiscordBot do
  @moduledoc """
  This is the main consumer process for the Ohio Elixir discord bot. All primary events flow through this.
  """

  use Nostrum.Consumer

  require Logger

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event(event) do
    Logger.warn("unhandled event: #{inspect(event)}")
  end
end
