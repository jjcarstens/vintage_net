defmodule Nerves.NetworkNG.RawConfig do
  defstruct []
  @type ifname :: String.t
  @type t :: %__MODULE__{}
end

defprotocol ToRawConfig do
  @doc "Convert some data into a raw config."
  def to_raw_config(data)
end
