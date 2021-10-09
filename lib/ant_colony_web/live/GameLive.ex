defmodule AntColonyWeb.GameLive do
  # If you generated an app with mix phx.new --live,
  # the line below would be: use MyAppWeb, :live_view
  use Surface.LiveView
  alias AntColonyWeb.Components.{Workers, Queen, Nest}
  alias AntColony.{ColonyServer}

  def render(assigns) do
    ~F"""
    <Nest  name={@nest.name} nest_size={@nest.nest_size} food={@nest.food}/>
    <Workers workers={@workers}/>
    <Queen name={@queen.name} action={@queen.action} />
    """
  end

  def mount(_params, _session, socket) do
    {:ok, colony} = ColonyServer.start_link([])

    {:ok,
     assign(socket, %{
       queen: ColonyServer.stats(colony, :queen),
       nest: ColonyServer.stats(colony, :nest),
       workers: ColonyServer.stats(colony, :workers)
     })}
  end
end
