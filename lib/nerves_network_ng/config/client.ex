defmodule Nerves.NetworkNG.Config.Client do
  defstruct [:interfaces]
  alias Nerves.NetworkNG.Config.{Client, Static}

  defimpl Nerves.NetworkNG.ConfigProcessor, for: Client do
    def process(_settings) do
      # idek
    end
  end


  def process_settings(interface, %Static{
    address: addres,
    subnet: subnet,
    gateway: gateway,
    network: network,
    broadcast: broadcast
  }) do
    """
    auto #{interface}
    iface #{interface} inet static
        address #{tuple_to_addr(addres)}
        netmask #{tuple_to_addr(subnet)}
        network #{tuple_to_addr(network)}
        broadcast #{tuple_to_addr(broadcast)}
        gateway #{tuple_to_addr(gateway)}
    """
  end

  def tuple_to_addr({_, _, _, _} = ip) do
    Tuple.to_list(ip)
    |> Enum.join(".")
  end
end
