defmodule AntColony.QueenServer do
  use GenServer
  alias AntColony.ActionServer

  def start_link(init_args) do
    GenServer.start_link(__MODULE__, [init_args])
  end

  def init(_args) do
    {:ok, %{name: "Queen name", action: nil}}
  end

  def handle_cast({:make_worker, colony_pid}, state) do
    IO.inspect("MAKE WORKER", label: __MODULE__)

    {:ok, action} =
      GenServer.start_link(ActionServer, %{
        name: "make worker",
        cost: 100,
        callback: fn -> GenServer.cast(colony_pid, :make_worker) end
      })

    {:noreply, %{state | action: action}}
  end
end
