defmodule Collidex.TestUtils do
  use ExSpec, async: true
  # use ExCheck

  doctest Collidex.Utils
  alias Collidex.Utils
  alias Collidex.Geometry.Polygon

  describe "normals_of_edges" do
    context "For a unit rectangle" do
      it "returns unit vectors in the four cardinal directions" do
        shape = Polygon.make([{0,0}, {0,1.0}, {1.0, 1.0}, {1.0, 0}])
        normals = Utils.normals_of_edges(shape) |> IO.inspect
        assert Utils.normals_of_edges(shape)
          -- [{-1.0,0.0}, {0.0, 1.0}, {1.0,0.0}, {0.0, -1.0}] == []
      end
    end
  end

  describe "unit_vector" do
    it "returns a unit-length vector in the same direction as its argument" do
      assert {1.0, 0.0} == Utils.unit_vector({1.0,0.0})
      assert {0.0, -1.0} == Utils.unit_vector({0.0,-20.0})

      {x, y} = Utils.unit_vector({5.0,5.0})
      assert_in_delta x, 1.4142135623730951, 0.01
      assert_in_delta y, 1.4142135623730951, 0.01
    end
  end

end
