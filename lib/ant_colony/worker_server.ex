defmodule AntColony.WorkerServer do
  use GenServer

  def start_link(init_args \\ %{name: "Darrel"}) do
    GenServer.start_link(__MODULE__, init_args)
  end

  def init(worker) do
    {:ok, %{name: worker.name, action: nil}}
  end
end
