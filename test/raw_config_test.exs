defmodule Nerves.NetworkNG.RawConfigTest do
  use ExUnit.Case, async: true
  alias Nerves.NetworkNG.RawConfig

  def fixture do
    %RawConfig{
      interfaces: %{"wlan0" => """
      auto wlan0
      iface wlan0 inet dhcp
        pre-up wpa_supplicant -B w -i wlan0 -c -P <%= @wlan0_wpa_pid_file %> -c <%= @wlan0_wpa_conf_file %> -dd
        post-down [ -e <%= @wlan0_wpa_pid_file %> ] && (kill $(cat <%= @wlan0_wpa_pid_file %>); rm <%= @wlan0_wpa_pid_file %>)
      """,
      "eth0" => """
      auto eth0
      iface eth0 inet dhcp
      """
      },
      wpa_supplicant: %{"wlan0" => """
      ap_scan=1

      network={
        ssid="SSID string "
        scan_ssid=1
        proto=WPA RSN
        key_mgmt=WPA-PSK
        pairwise=CCMP TKIP
        group=CCMP TKIP
        psk="SUPER SECRET"
      }
      """,
      "eth0" => nil},
      udhcpd: %{"eth0" => nil, "wlan0" => nil}
    }
  end

  test "writes the fixture" do
    RawConfig.write(fixture())
  end
end
