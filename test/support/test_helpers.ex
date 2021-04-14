defmodule OhioElixir.TestHelpers do
  def reload(%module{id: id}), do: OhioElixir.Repo.get(module, id)
end
