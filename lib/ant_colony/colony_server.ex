defmodule AntColony.ColonyServer do
  use GenServer

  alias AntColony.QueenServer
  alias AntColony.NestServer
  alias AntColony.WorkerServer

  def start_link(init_args) do
    GenServer.start_link(__MODULE__, [init_args])
  end

  @impl true
  def init(_args) do
    {:ok, nest} = NestServer.start_link([])
    {:ok, worker} = WorkerServer.start_link([])
    {:ok, queen} = QueenServer.start_link([])

    {:ok, %{nest: nest, queen: queen, workers: [worker]}}
  end

  @spec stats(pid(), atom()) :: map() | list()
  def stats(pid, :workers) do
    :sys.get_state(pid).workers |> Enum.map(fn worker -> :sys.get_state(worker) end)
  end

  def stats(pid, atom) do
    :sys.get_state(pid)[atom] |> :sys.get_state()
  end
end
