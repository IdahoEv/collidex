defmodule TestListDetector do
  use ExSpec, async: true

  doctest Collidex.ListDetector
  alias Collidex.ListDetector
  alias Collidex.Geometry.Polygon
  alias Collidex.Geometry.Circle
  alias Collidex.Geometry.Rect

  @doc """
  A visualization of these fixture examples can be found in
  test/collidex/detection/sat_examples.pdf
  """
  def make_fixtures do
    %{
      a: Polygon.make([{98.14,201.81},{68.22,173.46},{77.8,133.38},{177.31,121.64},{147.24,149.98},{137.65,190.07}]),
      b: Polygon.make([{91.42,157.29},{100.93,164.2},{97.3,175.38},{85.54,175.38},{81.91,164.2}]),
      c: Polygon.make([{96.01,116.82},{105.52,123.73},{101.89,134.91},{90.13,134.91},{86.5,123.73}]),
      d: Polygon.make([{130.19,157.65},{162.97,100.86},{195.75,157.65}]),
      e: Polygon.make([{177.62,107.72},{243.18,106.13},{211.78,163.7}]),
      f: Polygon.make([{160.08,190.49},{196.3,201.52},{204.86,238.4},{177.21,264.25},{140.99,253.23},{132.42,216.35}]),
      g: Polygon.make([{196.3,201.52},{202.75,185.00},{225.25,190.49},{220.76,206.75}]),
      r1: Rect.make(100.93, 213, 122.73, 205.22),
      r2: Rect.make(173.0, 163.7, 140.12, 146.45),
      r3: Rect.make(188.25, 266.25, 203, 279),
      c1: Circle.make(112.73, 219.33, 10),
      c2: Circle.make(195.763, 272.326, 25),
      c3: Circle.make(243.18, 141.823, 25)
    }
  end


  describe "find_collisions/3" do
    it "should return an empty list for two empty lists" do
      assert [] == ListDetector.find_collisions([],[])
    end

    it "should return an empty list when either list is empty" do
      fixture = [ Collidex.Geometry.Circle.make(0.0, 0.0, 1.0)]
      assert [] = ListDetector.find_collisions([], fixture)
      assert [] = ListDetector.find_collisions(fixture, [])
    end

    context "when no geometries in either list lists collide" do
      it "should return [] for a simple case" do
        a = Collidex.Geometry.Circle.make(0.0, 0.0, 1.0)
        b = Collidex.Geometry.Circle.make(5.0, 5.0, 1.0)
        assert [] = ListDetector.find_collisions([a], [b])
        assert [] = ListDetector.find_collisions([b], [a])
      end
      it "should return [] for a larger case" do
        fix = make_fixtures
        assert [] == ListDetector.find_collisions(
          [fix.c, fix.e, fix.c1],
          [fix.b, fix.g, fix.c2, fix.r2]
        )
      end
    end

    context "when geometries collide within one list but not with the other" do
      it "should return []" do
        fix = make_fixtures
        assert [] == ListDetector.find_collisions(
          [fix.a, fix.b, fix.c],
          [fix.e, fix.c3, fix.r3]
        )
      end
    end

    context "when there are colliding geometries" do
     it "should detect identical geometries in the two lists " do
       fix = make_fixtures
       assert [ { fix.a, fix.a, "todo_provide_vector" } ] == ListDetector.find_collisions(
         [fix.a],
         [fix.a]
       )
     end
     it "should detect intersecting geometries in the two lists " do
       fix = make_fixtures
       list_1 = [fix.a, fix.c2]
       list_2 = [fix.b, fix.d, fix.e, fix.r3]
       expected_result = [
         { fix.a, fix.b, "todo_provide_vector" },
         { fix.a, fix.d, "todo_provide_vector" },
         { fix.c2, fix.r3, "todo_provide_vector" },
       ]
       assert expected_result == ListDetector.find_collisions(list_1, list_2)
     end
    end
  end
end
