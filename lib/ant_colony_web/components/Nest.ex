defmodule AntColonyWeb.Components.Nest do
  # If you generated an app with mix phx.new --live,
  # the line below would be: use MyAppWeb, :live_view
  use Surface.Component
  prop name, :string, required: true
  prop nest_size, :integer, required: true
  prop food, :integer, required: true
  # prop max_nest_size, :integer

  def render(assigns) do
    ~F"""
    <section>
      <h1>{@name}</h1>
      <p>{@nest_size}</p>
      <p>{@food}</p>
    </section>
    """
  end
end
