defmodule OhioElixirWeb.MeetingView do
  use OhioElixirWeb, :view

  def active_options(true), do: [onclick: "this.form.submit()", checked: "true"]
  def active_options(false), do: [onclick: "this.form.submit()"]
end
