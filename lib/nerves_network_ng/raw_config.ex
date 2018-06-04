defmodule Nerves.NetworkNG.RawConfig do
  alias Nerves.NetworkNG.RawConfig
  defstruct [
    :interfaces,
    :wpa_supplicant,
    :udhcpd,
  ]

  @type ifname :: String.t

  @type t :: %RawConfig{
    interfaces: %{optional(ifname) => String.t},
    wpa_supplicant: %{optional(ifname) => String.t},
    udhcpd: %{optional(ifname) => String.t},
  }

  @etc_network_interfaces_path Application.get_env(:nerves_network_ng, :etc_network_interfaces_path, Path.join(["/etc", "network", "interfaces"]))
  def write(%RawConfig{} = conf) do
    ifaces = Map.keys(conf.interfaces)
    render_opts = Enum.map(ifaces, fn(ifname) ->
      [
        {String.to_atom(ifname <> "_wpa_pid_file"), wpa_supplicant_conf_path(ifname)},
        {String.to_atom(ifname <> "_wpa_conf_file"), wpa_supplicant_pid_path(ifname)}
      ]
    end) |> List.flatten()

    # Create directories we might need.
    File.mkdir_p! Path.dirname(@etc_network_interfaces_path)
    for ifname <- ifaces, do: File.mkdir_p! conf_dir(ifname)

    # Render /etc/network/interfaces and write it.
    ifaces_file_contents = Enum.map(conf.interfaces, &elem(&1, 1))
      |> Enum.join("\r\n")
      |> render_file(render_opts)

    File.write(@etc_network_interfaces_path, ifaces_file_contents)

    # render the other fields and write them.
    for ifname <- ifaces do

      if conf.wpa_supplicant[ifname] do
        wpa_conf_file_contents = render_file(conf.wpa_supplicant[ifname], render_opts)
        File.write!(wpa_supplicant_conf_path(ifname), wpa_conf_file_contents)
      end

      if conf.udhcpd[ifname] do
        udhcpd_file_contents = render_file(conf.udhcpd[ifname], render_opts)
        File.write!(Path.join(wpa_supplicant_pid_path(ifname)), udhcpd_file_contents)
      end

    end
  end

  defp wpa_supplicant_conf_path(ifname) do
    Path.join([conf_dir(ifname), "wpa_supplicant.pid"])
  end

  defp wpa_supplicant_pid_path(ifname) do
    Path.join([conf_dir(ifname), "wpa_supplicant.conf"])
  end

  defp conf_dir(ifname) do
    Path.join(["/tmp", ifname])
  end

  defp render_file(data, opts) do
    EEx.eval_string(data, [assigns: opts])
  end
end

defprotocol ToRawConfig do
  @doc "Convert some data into a raw config."
  def to_raw_config(data)
end
