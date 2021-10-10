defmodule AntColonyWeb.Components.Worker do
  # If you generated an app with mix phx.new --live,
  # the line below would be: use MyAppWeb, :live_view
  use Surface.Component
  prop name, :string, required: true
  prop action, :map

  def render(assigns) do
    ~F"""
        {@name}
        {#if @action}
          {@action.name}
          {@action.progress}/{@action.cost}
        {/if}
    """
  end
end
