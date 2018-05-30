defmodule Nerves.NetworkNG.Platform do
  #TODO(Connor) - Make that a link for exdoc.
  @moduledoc "Platform for a ConfigProcessor implementation to target."

  @type t :: map

  @doc "Apply Platform Config to `ifup` or `ifdown`"
  @callback apply(t) :: :ok | {:error, term}

  #IDEA(Connor) - Maybe define a validate behaviour before application.
end
