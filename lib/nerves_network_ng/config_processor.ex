defprotocol Nerves.NetworkNG.ConfigProcessor do

  @doc """
  Process the Nerves.Config structs.
  """
  def process(data)
end
