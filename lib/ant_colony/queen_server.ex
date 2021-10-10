defmodule AntColony.QueenServer do
  use GenServer
  alias AntColony.ActionServer

  def start_link(init_args) do
    GenServer.start_link(__MODULE__, [init_args])
  end

  def init(_args) do
    {:ok, %{name: "Queen name", action: nil}}
  end

  def handle_cast({:make_worker, colony_pid, worker}, state) do
    {:ok, action} =
      GenServer.start_link(ActionServer, %{
        name: "make worker",
        cost: worker.cost,
        callback: fn -> GenServer.cast(colony_pid, {:make_worker, worker}) end
      })

    {:noreply, %{state | action: action}}
  end
end
