defmodule OhioElixirWeb.ViewHelpers.Date do
  def format_date_time(datetime) do
    datetime
    |> DateTime.shift_zone!("America/New_York")
    |> Calendar.strftime("%Y-%m-%d %I:%M:%S %p EST")
  end
end
