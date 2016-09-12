defmodule TestMixedShapes do
  use ExSpec, async: true
  # use ExCheck

  doctest Collidex.Detection.MixedShapes
  alias Collidex.Detection.MixedShapes
  alias Collidex.Geometry.Rect
  alias Collidex.Geometry.Circle
  alias Collidex.Geometry.Polygon

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

  describe "Circles and polygons" do
    it "detects simple collision" do
      assert MixedShapes.collision?(
        Circle.make(0.0,0.0,1.0),
        Polygon.make([{1,0}, {2,1}, {3,0}, {2,-1}])
      )
    end
    it "detects simple miss" do
      refute MixedShapes.collision?(
        Circle.make(0.0,0.0,1.0),
        Polygon.make([{1.5,0}, {2,1}, {3,0}, {2,-1}])
      )
    end
    it "detects collisions" do
      fixtures = make_fixtures
      assert MixedShapes.collision?(fixtures.c2,fixtures.f)
      assert MixedShapes.collision?(fixtures.c3,fixtures.e)

      assert MixedShapes.collision?(fixtures.f,fixtures.c2)
      assert MixedShapes.collision?(fixtures.e,fixtures.c3)
    end
    it "detects misses" do
      fixtures = make_fixtures
      refute MixedShapes.collision?(fixtures.c1, fixtures.f)
      [{ :c1, :b}, { :c1, :c}, { :c1, :d}, { :c1, :e}, { :c1, :f}, { :c1, :g},
       { :c2, :a}, { :c2, :b}, { :c2, :c}, { :c2, :d}, { :c2, :e}, { :c2, :g},
       { :c3, :a}, { :c3, :b}, { :c3, :c}, { :c3, :d}, { :c3, :f}, { :c3, :g},
      ]
      |> Enum.each(fn({name1, name2}) ->
        shape1 = Map.fetch!(fixtures, name1)
        shape2 = Map.fetch!(fixtures, name2)
        refute MixedShapes.collision?(shape1, shape2),
          "Expected no collision between shapes #{name1} and #{name2}"
        refute MixedShapes.collision?(shape2, shape1),
          "Expected no collision between shapes #{name1} and #{name2}"
      end)
    end
  end

  describe "Rectangles and polygons" do
    it "should detect collisions between rectangles and polygons" do
      fixtures = make_fixtures
      assert MixedShapes.collision?(fixtures.r2,fixtures.d)
      assert MixedShapes.collision?(fixtures.r2,fixtures.a)

      #check both argument orders
      assert MixedShapes.collision?(fixtures.d,fixtures.r2)
      assert MixedShapes.collision?(fixtures.a,fixtures.r2)
    end
    it "should detect misses between rectangles and polygons" do
      fixtures = make_fixtures
      refute MixedShapes.collision?(fixtures.r1,fixtures.a)
      refute MixedShapes.collision?(fixtures.r1,fixtures.b)
      refute MixedShapes.collision?(fixtures.r1,fixtures.c)
      refute MixedShapes.collision?(fixtures.r1,fixtures.d)
      refute MixedShapes.collision?(fixtures.r1,fixtures.e)
      refute MixedShapes.collision?(fixtures.r3,fixtures.a)
      refute MixedShapes.collision?(fixtures.r3,fixtures.b)
      refute MixedShapes.collision?(fixtures.r3,fixtures.c)
      refute MixedShapes.collision?(fixtures.r3,fixtures.d)
      refute MixedShapes.collision?(fixtures.r3,fixtures.e)

      #check both argument orders
      refute MixedShapes.collision?(fixtures.a, fixtures.r1)
      refute MixedShapes.collision?(fixtures.b, fixtures.r1)
      refute MixedShapes.collision?(fixtures.c, fixtures.r1)
      refute MixedShapes.collision?(fixtures.d, fixtures.r1)
      refute MixedShapes.collision?(fixtures.e, fixtures.r1)
      refute MixedShapes.collision?(fixtures.a, fixtures.r3)
      refute MixedShapes.collision?(fixtures.b, fixtures.r3)
      refute MixedShapes.collision?(fixtures.c, fixtures.r3)
      refute MixedShapes.collision?(fixtures.d, fixtures.r3)
      refute MixedShapes.collision?(fixtures.e, fixtures.r3)
    end
  end
end
