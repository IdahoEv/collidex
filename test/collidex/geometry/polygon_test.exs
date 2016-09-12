defmodule TestPolygon do
  use ExSpec, async: true

  doctest Collidex.Geometry.Polygon
  alias Collidex.Geometry.Polygon
  alias Collidex.Geometry.Rect

  describe "make" do
    context "from a list of points" do
      poly = Polygon.make([{0,0}, {1,0}, {1,1}, {1.5,0.5}, {1,0}])
      assert is_map(poly) == true
      assert poly == %Polygon{ vertices: [{0,0}, {1,0}, {1,1}, {1.5,0.5}, {1,0}] }
    end

    context "from a rect" do
      it "should make the correct polygon from non-negative integers" do
        rect1 = Rect.make(0,0,1,1)
        poly1 = Polygon.make(rect1)
        rect2 = Rect.make(0,1,1,0)
        poly2 = Polygon.make(rect2)

        correct_vertices = [{0,0}, {0,1}, {1,0}, {1,1}]
        %Polygon{ vertices: vertices1} = poly1
        %Polygon{ vertices: vertices2} = poly2

        # Polygons are assumed convex, so vertex order is
        # mostly unimportant.  (Not strictly true: a bowtie
        # of the rect's corners would be a bad polygon for
        # collision purposes).  May add a test for that at
        # some point but it feels overkill at the moment.
        assert correct_vertices -- vertices1 == []
        assert correct_vertices -- vertices2 == []
      end
      it "should make the correct polygon from floats" do
        rect1 = Rect.make(1.57,-3.2,-26.4,-1.111)
        poly1 = Polygon.make(rect1)
        rect2 = Rect.make(-26.4,-3.2,1.57,-1.111)
        poly2 = Polygon.make(rect2)

        correct_vertices = [{-26.4,-3.2}, {1.57,-3.2}, {1.57,-1.111}, {-26.4,-1.111}]
        %Polygon{ vertices: vertices1} = poly1
        %Polygon{ vertices: vertices2} = poly2

        # Polygons are assumed convex, so vertex order is
        # unimportant.
        assert correct_vertices -- vertices1 == []
        assert correct_vertices -- vertices2 == []
      end
    end
  end

  describe "center" do
    context "of a (grid-aligned) rectangle" do
      {x, y} = Polygon.center(Polygon.make([{1,1}, {1,-1}, {-1,-1}, {-1, 1}]))
      assert_in_delta(x, 0.0, 0.00001)
      assert_in_delta(y, 0.0, 0.00001)
    end
    context "of a regular pentagon centered on 1,1" do
      {x,y} = Polygon.center(Polygon.make([{1.2150,1.0}, {1.0664, 0.7955}, {0.8261, 0.8736}, {0.8261, 1.1264}, {1.0664, 1.2045}]))
      assert_in_delta(x, 1.0, 0.00001)
      assert_in_delta(y, 1.0, 0.00001)
    end
  end

end
