defmodule AntColony.NestServer do
  use GenServer

  def start_link(init_args) do
    GenServer.start_link(__MODULE__, [init_args])
  end

  def init(_args) do
    {:ok, %{name: "colony name", food: 200, nest_size: 10}}
  end
end
