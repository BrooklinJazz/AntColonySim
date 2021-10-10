defmodule AntColonyWeb.Components.Workers do
  # If you generated an app with mix phx.new --live,
  # the line below would be: use MyAppWeb, :live_view
  use Surface.Component
  alias AntColonyWeb.Components.Worker

  prop workers, :list, required: true

  def render(assigns) do
    ~F"""
    <section>
      <h1>Workers</h1>
      {#for worker <- @workers}
        <Worker name={worker.name} />
      {/for}
    </section>
    """
  end
end
