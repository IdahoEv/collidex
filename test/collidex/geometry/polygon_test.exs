defmodule TestPolygon do
  use ExSpec, async: true

  doctest Collidex.Geometry.Polygon
  alias Collidex.Geometry.Polygon

  describe "make" do
    context "from a list of points" do
      poly = Polygon.make([{0,0}, {1,0}, {1,1}, {1.5,0.5}, {1,0}])
      assert is_map(poly) == true
      assert poly == %Polygon{ vertices: [{0,0}, {1,0}, {1,1}, {1.5,0.5}, {1,0}] }
    end
  end

  describe "center" do
    context "of a rectangle" do
      {x, y} = Polygon.center(Polygon.make([{1,1}, {1,-1}, {-1,-1}, {-1, 1}]))
      assert_in_delta(x, 0.0, 0.00001)
      assert_in_delta(y, 0.0, 0.00001)
    end
  end

end