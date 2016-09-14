defmodule Collidex.TestUtils do
  use ExSpec, async: true
  # use ExCheck

  doctest Collidex.Utils
  alias Collidex.Utils
  alias Collidex.Geometry.Polygon
  alias Collidex.Geometry.Circle

  describe "normals_of_edges/1" do
    context "For a unit rectangle" do
      it "returns unit vectors in the four cardinal directions" do
        shape = Polygon.make([{0,0}, {0,1.0}, {1.0, 1.0}, {1.0, 0}])
        assert Utils.normals_of_edges(shape)
          -- [{-1.0,0.0}, {0.0, 1.0}, {1.0,0.0}, {0.0, -1.0}] == []
      end
    end
  end

  describe "unit_vector/1" do
    it "returns a unit-length vector in the same direction as its argument" do
      assert {1.0, 0.0} == Utils.unit_vector({1.0,0.0})
      assert {0.0, -1.0} == Utils.unit_vector({0.0,-20.0})

      {x, y} = Utils.unit_vector({5.0,5.0})
      assert_in_delta x, 0.7071067811865476, 0.01
      assert_in_delta y, 0.7071067811865476, 0.01
    end
  end

  describe "project_onto_axis/2" do
    context "for polygons" do
      it "Projects onto the X axis correctly" do
        assert Utils.project_onto_axis(
            Polygon.make([{98.14,201.81},{68.22,173.46},{77.8,133.38},{177.31,121.64},{147.24,149.98},{137.65,190.07}]),
            {1.0, 0.0}
          ) == [98.14, 68.22, 77.8, 177.31, 147.24, 137.65]
      end
      it "Projects onto the negative Y axis correctly" do
        assert Utils.project_onto_axis(
            Polygon.make([{91.42,157.29},{100.93,164.2},{97.3,175.38},{85.54,175.38},{81.91,164.2}]),
            {0.0, -1.0}
          ) == [-157.29, -164.2, -175.38, -175.38, -164.2]
      end
      it "Projects onto an arbitrary axis correctly" do
        assert Utils.project_onto_axis(
            Polygon.make([{177.62,107.72},{243.18,106.13},{211.78,163.7}]),
            {1.34, 2.01}
        )
      end
    end
  end

  describe "extent_along_axis" do
    context "for polygons" do
      it "Projects onto the X axis correctly" do
        assert Utils.extent_on_axis(
            Polygon.make([{98.14,201.81},{68.22,173.46},{77.8,133.38},{177.31,121.64},{147.24,149.98},{137.65,190.07}]),
            {1.0, 0.0}
          ) == {68.22, 177.31}
      end
      it "Projects onto the negative Y axis correctly" do
        assert Utils.extent_on_axis(
            Polygon.make([{91.42,157.29},{100.93,164.2},{97.3,175.38},{85.54,175.38},{81.91,164.2}]),
            {0.0, -1.0}
          ) == {-175.38, -157.29}
      end
    end

    context "for circles" do
      it "Projects onto the X axis correctly" do
        assert Utils.extent_on_axis(Circle.make(0.0, 0.0, 1.0), {1.0, 0.0})
          == { -1.0, 1.0 }
        assert Utils.extent_on_axis(Circle.make(-3.5, 164.2, 2.0), {1.0, 0.0})
          == { -5.5, -1.5 }
      end
      it "Projects onto the -Y axis correctly" do
        assert Utils.extent_on_axis(Circle.make(0.0, 0.0, 1.0), {0.0, -1.0})
          == { -1.0, 1.0 }
        assert Utils.extent_on_axis(Circle.make(-3.5, 164.2, 2.0), {0.0, -1.0})
          == { -166.2, -162.2 }
      end


    end
  end

end
