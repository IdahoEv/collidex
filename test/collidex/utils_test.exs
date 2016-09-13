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

end
