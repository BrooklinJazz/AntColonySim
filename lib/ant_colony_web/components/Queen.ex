defmodule AntColonyWeb.Components.Queen do
  # If you generated an app with mix phx.new --live,
  # the line below would be: use MyAppWeb, :live_view
  use Surface.Component
  prop name, :string, required: true
  prop action, :any
  # prop max_nest_size, :integer

  def render(assigns) do
    ~F"""
    <section>
      <h1>{@name}</h1>
      {#if @action}
        <p>{@action.name}</p>
        <p>{@action.progress}/{@action.cost}</p>
      {/if}
    </section>
    """
  end
end
