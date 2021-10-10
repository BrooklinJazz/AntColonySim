defmodule AntColonyWeb.GameLive do
  # If you generated an app with mix phx.new --live,
  # the line below would be: use MyAppWeb, :live_view
  use Surface.LiveView
  alias AntColonyWeb.Components.{Workers, Queen, Nest}
  alias AntColony.{ColonyServer}

  @impl true
  def render(assigns) do
    ~F"""
    <Nest name={@nest.name} nest_size={@nest.nest_size} food={@nest.food}/>
    <Workers workers={@workers}/>
    <Queen name={@queen.name} action={@queen.action} />a
    <button phx-click="add">+</button>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: :timer.send_interval(1, self(), :update)

    {:ok,
     assign(socket, %{
       queen: ColonyServer.stats(ColonyServer, :queen),
       nest: ColonyServer.stats(ColonyServer, :nest),
       workers: ColonyServer.stats(ColonyServer, :workers)
     })}
  end

  def handle_info(:update, socket) do
    {:noreply,
     assign(socket, %{
       queen: ColonyServer.stats(ColonyServer, :queen),
       nest: ColonyServer.stats(ColonyServer, :nest),
       workers: ColonyServer.stats(ColonyServer, :workers)
     })}
  end

  @impl true
  def handle_event("add", _value, socket) do
    ColonyServer.make_worker(ColonyServer, %{name: "Test", cost: 5000})
    {:noreply, socket}
  end
end
