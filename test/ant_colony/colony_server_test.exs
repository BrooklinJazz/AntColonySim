defmodule AntColony.ColonyServerTest do
  use ExUnit.Case
  doctest AntColony.ColonyServer
  alias AntColony.ColonyServer

  describe "ColonyServer" do
    test "start" do
      assert {:ok, colony} = ColonyServer.start_link([])
      assert %{name: _, action: nil} = ColonyServer.stats(colony, :queen)
      assert [%{name: _, action: nil}] = ColonyServer.stats(colony, :workers)
      assert %{name: _, nest_size: 10, food: 200} = ColonyServer.stats(colony, :nest)
    end
  end
end
