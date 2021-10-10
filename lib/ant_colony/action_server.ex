defmodule AntColony.ActionServer do
  use GenServer
  @tick 10
  def start_link(%{name: _, cost: _, callback: _} = init_args) do
    GenServer.start_link(__MODULE__, init_args)
  end

  def init(%{name: _, cost: _, callback: _} = args) do
    tick()
    {:ok, Map.merge(args, %{progress: 0})}
  end

  def tick do
    Process.send_after(self(), :tick, @tick)
  end

  def handle_info(:tick, state) do
    if state.progress >= state.cost do
      state.callback.()
      {:noreply, state}
    else
      tick()
      {:noreply, %{state | progress: state.progress + @tick}}
    end
  end
end
