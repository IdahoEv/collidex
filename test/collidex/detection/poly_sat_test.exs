defmodule Collidex.Detection.PolySATTest do
  use ExSpec, async: true

  doctest Collidex.Detection.PolySAT
  alias Collidex.Detection.PolySAT
  alias Collidex.Geometry.Polygon

  def make_fixtures do
    %{
      a: Polygon.make([{98.14,201.81},{68.22,173.46},{77.8,133.38},{177.31,121.64},{147.24,149.98},{137.65,190.07}]),
      b: Polygon.make([{91.42,157.29},{100.93,164.2},{97.3,175.38},{85.54,175.38},{81.91,164.2}]),
      c: Polygon.make([{96.01,116.82},{105.52,123.73},{101.89,134.91},{90.13,134.91},{86.5,123.73}]),
      d: Polygon.make([{130.19,157.65},{162.97,100.86},{195.75,157.65}]),
      e: Polygon.make([{177.62,107.72},{243.18,106.13},{211.78,163.7}]),
      f: Polygon.make([{160.08,190.49},{196.3,201.52},{204.86,238.4},{177.21,264.25},{140.99,253.23},{132.42,216.35}]),
      g: Polygon.make([{196.3,201.52},{202.75,185.00},{225.25,190.49},{220.76,206.75}])
    }
  end

  describe "fast collision method" do
    it "detects collisions" do
      fixtures = make_fixtures
      # d and e are non-overlapping triangles but appear to be overlapping
      # when projected onto the centroid-centroid axis
      [{:a,:b}, {:a,:c}, {:a, :d}, {:d, :e}, {:f, :g} ]
      |> Enum.each(fn({name1, name2}) ->
        shape1 = Map.fetch!(fixtures, name1)
        shape2 = Map.fetch!(fixtures, name2)
        assert PolySAT.collision?(shape1, shape2, :fast),
          "Expected a collision between shapes #{name1} and #{name2}"
        assert PolySAT.collision?(shape2, shape1, :fast),
          "Expected a collision between shapes #{name2} and #{name1}"
      end)
    end
    it "detects misses" do
      fixtures = make_fixtures
      [{:a,:e}, {:b,:c}, {:b, :d}, {:a, :f}, {:a, :g}, {:e, :g} ]
      |> Enum.each(fn({name1, name2}) ->
        shape1 = Map.fetch!(fixtures, name1)
        shape2 = Map.fetch!(fixtures, name2)
        refute PolySAT.collision?(shape1, shape2, :fast),
          "Expected no collision between shapes #{name1} and #{name2}"
        refute PolySAT.collision?(shape2, shape1, :fast),
          "Expected no collision between shapes #{name1} and #{name2}"
      end)
    end
  end

  describe "accurate collision method" do
    it "detects collisions" do
      fixtures = make_fixtures
      [{:a,:b}, {:a,:c}, {:a, :d}, {:f, :g} ]
      |> Enum.each(fn({name1, name2}) ->
        shape1 = Map.fetch!(fixtures, name1)
        shape2 = Map.fetch!(fixtures, name2)
        assert PolySAT.collision?(shape1, shape2),
          "Expected a collision between shapes #{name1} and #{name2}"
        assert PolySAT.collision?(shape2, shape1),
          "Expected a collision between shapes #{name2} and #{name1}"
      end)
    end
    it "detects misses" do
      fixtures = make_fixtures

      # d and e are a miss when tested with full separating axis
      [{:a,:e}, {:b,:c}, {:b, :d}, {:a, :f}, {:a, :g}, {:e, :g}, {:d, :e} ]
      |> Enum.each(fn({name1, name2}) ->
        shape1 = Map.fetch!(fixtures, name1)
        shape2 = Map.fetch!(fixtures, name2)
        refute PolySAT.collision?(shape1, shape2),
          "Expected no collision between shapes #{name1} and #{name2}"
        refute PolySAT.collision?(shape2, shape1),
          "Expected no collision between shapes #{name1} and #{name2}"
      end)
    end
  end
end
