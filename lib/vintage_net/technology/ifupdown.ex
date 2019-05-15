defmodule VintageNet.Technology.IfupDown do
  @behaviour VintageNet.Technology
  alias VintageNet.Interface.RawConfig
  alias VintageNet.IP.ConfigToInterfaces

  @impl true
  def to_raw_config(%{ifname: ifname, source_config: config} = raw_config, opts) do
    ifup = Keyword.fetch!(opts, :bin_ifup)
    ifdown = Keyword.fetch!(opts, :bin_ifdown)
    tmpdir = Keyword.fetch!(opts, :tmpdir)
    network_interfaces_path = Path.join(tmpdir, "network_interfaces.#{ifname}")

    files = [
      {network_interfaces_path, ConfigToInterfaces.config_to_interfaces_contents(ifname, config)}
    ]

    up_cmds = [
      {:run, ifup, ["-i", network_interfaces_path, ifname]}
    ]

    down_cmds = [
      {:run, ifdown, ["-i", network_interfaces_path, ifname]}
    ]

    raw_config
    |> RawConfig.add_files(files)
    |> RawConfig.add_up_cmds(up_cmds)
    |> RawConfig.add_down_cmds(down_cmds)
    |> RawConfig.ok()
  end

  @impl true
  def ioctl(_ifname, _command, _args) do
    {:error, :unsupported}
  end

  @impl true
  def check_system(opts) do
    # TODO
    with :ok <- check_program(opts[:bin_ifup]) do
      :ok
    end
  end

  defp check_program(path) do
    if File.exists?(path) do
      :ok
    else
      {:error, "Can't find #{path}"}
    end
  end
end
