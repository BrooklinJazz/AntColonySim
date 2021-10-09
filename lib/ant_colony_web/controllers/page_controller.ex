defmodule AntColonyWeb.PageController do
  use AntColonyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
