defmodule Nerves.NetworkNG.Platform.Nerves do
  defstruct [
    :interfaces, # contents of /etc/network/interfaces
    :wpa_supplicant, # contents of /etc/wpa_supplicant.conf
    :udhcpd, # contents
    :reload # list of interfaces to be restarted.
  ]

  @behaviour Nerves.NetworkNG.Platform

  def apply(_config) do

  end
end
