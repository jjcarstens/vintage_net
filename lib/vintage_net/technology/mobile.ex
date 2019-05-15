defmodule VintageNet.Technology.Mobile do
  @behaviour VintageNet.Technology

  alias VintageNet.Interface.RawConfig

  @impl true
  def to_raw_config(%{source_config: %{pppd: pppd_config}} = raw_config, opts) do
    mknod = Keyword.fetch!(opts, :bin_mknod)
    killall = Keyword.fetch!(opts, :bin_killall)
    chat_bin = Keyword.fetch!(opts, :bin_chat)
    pppd = Keyword.fetch!(opts, :bin_pppd)

    files = [{"/tmp/chat_script", pppd_config.chat_script}]

    up_cmds = [
      {:run, mknod, ["/dev/ppp", "c", "108", "0"]},
      {:run, pppd, make_pppd_args(pppd_config, chat_bin)}
    ]

    down_cmds = [
      {:run, killall, ["-q", "pppd"]}
    ]

    raw_config
    |> RawConfig.add_files(files)
    |> RawConfig.add_up_cmds(up_cmds)
    |> RawConfig.add_down_cmds(down_cmds)
    |> RawConfig.ok()
  end

  def to_raw_config(raw_config, _opts) do
    {:ok, raw_config}
  end

  @impl true
  def ioctl(_ifname, _command, _args) do
    {:error, :unsupported}
  end

  @impl true
  def check_system(_opts) do
    # TODO
    :ok
  end

  defp make_pppd_args(pppd, chat_bin) do
    [
      "connect",
      "#{chat_bin} -v -f /tmp/chat_script",
      pppd.ttyname,
      "#{pppd.speed}"
    ] ++ Enum.map(pppd.options, &pppd_option_to_string/1)
  end

  defp pppd_option_to_string(:noipdefault), do: "noipdefault"
  defp pppd_option_to_string(:usepeerdns), do: "usepeerdns"
  defp pppd_option_to_string(:defaultroute), do: "defaultroute"
  defp pppd_option_to_string(:persist), do: "persist"
  defp pppd_option_to_string(:noauth), do: "noauth"
end
