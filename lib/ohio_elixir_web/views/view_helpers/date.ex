defmodule OhioElixirWeb.ViewHelpers.Date do
  @moduledoc false
  def format_date_time(datetime) do
    datetime
    |> DateTime.shift_zone!("America/New_York")
    |> Calendar.strftime("%Y-%m-%d %I:%M %p EST")
  end
end
