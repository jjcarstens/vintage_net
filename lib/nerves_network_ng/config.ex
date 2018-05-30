defmodule Nerves.NetworkNG.Config do
  @moduledoc """
  TODO(Connor) - Add documentation when you have something useful to say/do. BBL.
  """

  @doc "Apply a Platform config."
  def apply(config)
  def apply(%platform{} = config), do: apply(platform, :apply, [config])
end
