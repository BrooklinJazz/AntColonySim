defmodule AntColonyWeb.PageControllerTest do
  use AntColonyWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
  end
end
