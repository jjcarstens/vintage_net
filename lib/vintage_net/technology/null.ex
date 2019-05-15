defmodule VintageNet.Technology.Null do
  @behaviour VintageNet.Technology

  alias VintageNet.Interface.RawConfig

  @moduledoc """
  An interface with this technology is unconfigured
  Putting the null technology in a stack will clear
  the stack of config up to this point.
  """
  @impl true
  def to_raw_config(%{ifname: ifname} = raw_config, _opts \\ []) do
    {:ok,
     %RawConfig{
       ifname: ifname,
       type: raw_config.type,
       source_config: raw_config.source_config,
       require_interface: false
     }}
  end

  @impl true
  def ioctl(_ifname, _command, _args) do
    {:error, :unsupported}
  end

  @impl true
  def check_system(_opts), do: :ok
end
