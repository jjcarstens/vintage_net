defmodule Nerves.NetworkNG.Config.Static do
  @moduledoc """
  Configuration for a static ip address.
  """
  defstruct [:address, :subnet, :gateway, :network, :broadcast]
end
