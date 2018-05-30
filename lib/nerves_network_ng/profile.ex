defmodule Nerves.NetworkNG.Profile do
  alias Nerves.NetworkNG.RawConfig

  @moduledoc false
  @type ifname :: RawConfig.ifname
  @callback settings(ifname) :: {:ok, RawConfig.t}
end
