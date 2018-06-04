defmodule Nerves.NetworkNG.Profile.WirelessDHCPClient do
  @moduledoc """
  Profile for wireless configs.
  """

  import Nerves.NetworkNG.ProfileBuilder
  @behaviour Nerves.NetworkNG.Profile

  def settings(ifname) do
    # settings = [ssid: "hey!", psk: "whoops"]
    # iface(ifname)
    # |> wireless(settings)
    # |> dhcp()
    # |> commit()
  end

end
