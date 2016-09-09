defmodule TestCircles do
  use ExSpec, async: true
  # use ExCheck

  doctest Collidex.Detection.Circles
  alias Collidex.Detection.Circles
  alias Collidex.Geometry.Circle

  describe "circle to circle collisions" do
    it "Can detect collisions in the SE quadrant" do
      c1 = Circle.make(1.0,1.0,0.5)
      assert {:collision, _ } = Circles.collision?(c1, Circle.make(0.5,0.5,0.5))
      assert {:collision, _ } = Circles.collision?(c1, Circle.make(1.5,1.5,0.5))
      assert {:collision, _ } = Circles.collision?(c1, Circle.make(0.5,1.5,0.5))
      assert {:collision, _ } = Circles.collision?(c1, Circle.make(1.5,0.5,0.5))
      assert {:collision, _ } = Circles.collision?(c1, Circle.make(1.0,1.0,0.25))
    end
    it "Can detect misses in the SE quadrant " do
      c1 = Circle.make(1.0,1.0,0.5)
      refute Circles.collision?(c1, Circle.make(2.0,2.0,0.5))
      refute Circles.collision?(c1, Circle.make(2.0,1.0,0.125))
    end
    it "Can detect collisions in the NE quadrant" do
      c1 = Circle.make(2.0,-1.5,0.25)
      assert {:collision, _ } = Circles.collision?(c1, Circle.make(2.0,-1.5,0.25))
      assert {:collision, _ } = Circles.collision?(c1, Circle.make(1.0,-1.5,1.5))
      assert {:collision, _ } = Circles.collision?(c1, Circle.make(2.0,-1.25,0.25))
      assert {:collision, _ } = Circles.collision?(c1, Circle.make(0.0,0.0,2.5))
    end
    it "Can detect misses in the NE quadrant " do
      c1 = Circle.make(2.0,-1.5,0.25)
      refute Circles.collision?(c1, Circle.make(2.0,-2.0,0.1))
      refute Circles.collision?(c1, Circle.make(2.5,-0.5,0.5))
    end
  end
end
