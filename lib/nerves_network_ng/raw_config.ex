defmodule Nerves.NetworkNG.RawConfig do
  alias Nerves.NetworkNG.RawConfig
  defstruct [
    :interfaces,
    :wpa_supplicant,
    :udhcpd,
    :reload
  ]
  @type ifname :: String.t
  @type t :: %RawConfig{}

  @interfaces_path Path.join(["etc", "network", "interfaces"])
  @wpa_supplicant_path Path.join(["etc", "wpa_supplicant.conf"])
  @udhcpd_path Path.join(["etc", "udhcpd.conf"])

  def write(%RawConfig{} = conf) do
    File.write!(@interfaces_path, conf.interfaces)
    File.write!(@wpa_supplicant_path, conf.wpa_supplicant)
    File.write!(@udhcpd_path, conf.udhcpd_path)
  end

  def apply(%RawConfig{} = conf) do
    # essentially something like: System.cmd("ifup", conf.reload) or something.
  end
end

defprotocol ToRawConfig do
  @doc "Convert some data into a raw config."
  def to_raw_config(data)
end
