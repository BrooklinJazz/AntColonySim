defmodule AntColony.ColonyServer do
  use GenServer

  alias AntColony.QueenServer
  alias AntColony.NestServer
  alias AntColony.WorkerServer

  def start_link(init_args) do
    GenServer.start_link(__MODULE__, [init_args], name: __MODULE__)
  end

  @impl true
  def init(_args) do
    {:ok, nest} = NestServer.start_link([])
    {:ok, worker} = WorkerServer.start_link([])
    {:ok, queen} = QueenServer.start_link([])

    {:ok, %{nest: nest, queen: queen, workers: [worker]}}
  end

  @impl true
  def handle_cast(:make_worker, state) do
    {:ok, worker} = WorkerServer.start_link([])
    {:noreply, %{state | workers: [worker | state.workers]}}
  end

  def make_worker(colony_pid) do
    GenServer.cast(queen(colony_pid), {:make_worker, colony_pid})
  end

  @spec stats(pid(), atom()) :: map() | list()
  def stats(pid, :workers) do
    :sys.get_state(pid).workers |> Enum.map(fn worker -> :sys.get_state(worker) end)
  end

  def stats(pid, :queen) do
    queen_state = :sys.get_state(pid).queen |> :sys.get_state()
    %{name: queen_state.name, action: queen_state.action && :sys.get_state(queen_state.action)}
  end

  def stats(pid, atom) do
    :sys.get_state(pid)[atom] |> :sys.get_state()
  end

  defp queen(colony_pid) do
    :sys.get_state(colony_pid)[:queen]
  end
end
