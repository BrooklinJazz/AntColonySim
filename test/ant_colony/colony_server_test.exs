defmodule AntColony.ColonyServerTest do
  use ExUnit.Case
  doctest AntColony.ColonyServer
  alias AntColony.ColonyServer

  describe "ColonyServer" do
    test "start" do
      {:ok, colony} = ColonyServer.start_link([], :test)
      assert %{name: _, action: nil} = ColonyServer.stats(colony, :queen)
      assert [] = ColonyServer.stats(colony, :workers)
      assert %{name: _, nest_size: 10, food: 200} = ColonyServer.stats(colony, :nest)
    end

    test "make worker" do
      {:ok, colony} = ColonyServer.start_link([], :test)
      assert %{name: _, action: nil} = ColonyServer.stats(colony, :queen)
      ColonyServer.make_worker(colony, %{cost: 100, name: "Jerry"})

      assert %{action: %{name: "make worker", progress: 0, cost: 100}} =
               ColonyServer.stats(colony, :queen)

      Process.sleep(200)

      assert %{action: %{name: "make worker", progress: 100, cost: 100}} =
               ColonyServer.stats(colony, :queen)

      assert [%{name: "Jerry"}] = ColonyServer.stats(colony, :workers)
    end
  end
end
