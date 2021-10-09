defmodule AntColonyWeb.ColonyLive do
  # If you generated an app with mix phx.new --live,
  # the line below would be: use MyAppWeb, :live_view
  use Phoenix.LiveView

  def render(assigns) do
    ~H"""
    COLONY
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
