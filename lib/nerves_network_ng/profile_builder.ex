defmodule Nerves.NetworkNG.ProfileBuilder do
  @moduledoc """
  DSL for build Network configs.
  """
  defstruct [:iface, :configs]

  defmacro iface(ifname, config) do
    require IEx; IEx.pry
  end
end

defimpl ToRawConfig, for: Nerves.NetworkNG.ProfileBuilder do
  def to_raw_config(_data) do
    struct(Nerves.NetworkNG.RawConfig, [])
  end
end
