defmodule AntColony.QueenServer do
  use GenServer

  def start_link(init_args) do
    GenServer.start_link(__MODULE__, [init_args])
  end

  def init(_args) do
    {:ok, %{name: "Queen name", action: nil}}
  end
end
