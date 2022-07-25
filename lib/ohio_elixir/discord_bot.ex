defmodule OhioElixirBot.DiscordBot do
  @moduledoc """
  This is the main consumer process for the Ohio Elixir discord bot. All primary events flow through this.
  """

  use Nostrum.Consumer

  require Logger

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  # Catchall to keep the bot process from crashing on one of the many unhandled
  # Discord events that will inevitably come through
  def handle_event(event) do
    Logger.debug("unhandled event: #{inspect(event)}")
  end

  end
end
