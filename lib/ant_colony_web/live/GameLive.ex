defmodule AntColonyWeb.GameLive do
  # If you generated an app with mix phx.new --live,
  # the line below would be: use MyAppWeb, :live_view
  use Surface.LiveView
  alias AntColonyWeb.Components.{Workers, Queen, Nest}
  alias AntColony.{WorkerServer, QueenServer, NestServer}
  @topic "deployments"

  def render(assigns) do
    ~F"""
    <Nest  name={@nest.name} nest_size={@nest.nest_size} food={@nest.food}/>
    <Workers workers={@workers}/>
    <Queen name={@queen.name} action={@queen.action} />
    """
  end

  def mount(_params, _session, socket) do
    {:ok, nest_server} = NestServer.start_link([])
    {:ok, worker_server} = WorkerServer.start_link([])
    {:ok, queen_server} = QueenServer.start_link([])

    {:ok,
     assign(socket, %{
       queen: :sys.get_state(queen_server),
       nest: :sys.get_state(nest_server),
       workers: [:sys.get_state(worker_server)]
     })}
  end
end
