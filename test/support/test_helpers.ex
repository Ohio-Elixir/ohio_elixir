defmodule OhioElixir.TestHelpers do
  @moduledoc false
  def reload(%module{id: id}), do: OhioElixir.Repo.get(module, id)
end
