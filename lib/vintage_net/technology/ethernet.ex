defmodule VintageNet.Technology.Ethernet do
  @behaviour VintageNet.Technology
  alias VintageNet.Interface.RawConfig

  @impl true
  def to_raw_config(%RawConfig{} = raw_config, _opts) do
    {:ok, %{raw_config | up_cmd_millis: 60_000, down_cmd_millis: 5_000}}
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
