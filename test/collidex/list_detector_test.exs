defmodule TestListDetector do
  use ExSpec, async: true

  doctest Collidex.ListDetector
  alias Collidex.ListDetector

  describe "find_collisions/3" do
    it "should return an empty list for two empty lists" do
      assert [] == ListDetector.find_collisions([],[])
    end

    it "should return an empty list when either list is empty" do
      fixture = [ Collidex.Geometry.Circle.make(0.0, 0.0, 1.0)]
      assert [] = ListDetector.find_collisions([], fixture)
      assert [] = ListDetector.find_collisions(fixture, [])
    end

    it "should return an empty list when geometries in the list do not collide" do
      a = Collidex.Geometry.Circle.make(0.0, 0.0, 1.0)
      b = Collidex.Geometry.Circle.make(5.0, 5.0, 1.0)
      assert [] = ListDetector.find_collisions([a], [b])
      assert [] = ListDetector.find_collisions([b], [a])
    end

  end
end
