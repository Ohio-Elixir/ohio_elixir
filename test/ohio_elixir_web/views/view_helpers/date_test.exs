defmodule OhioElixirWeb.ViewHelpers.DateTest do
  use OhioElixirWeb.ConnCase, async: true
  alias OhioElixirWeb.ViewHelpers.Date

  describe "format_datetime/1" do
    test "returns a formatted date time in EST" do
      assert Date.format_date_time(~U[2021-04-06 21:00:00Z]) == "2021-04-06 05:00:00 PM EST"
    end
  end
end
