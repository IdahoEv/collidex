defmodule TestRects do
  use ExSpec, async: true
  # use ExCheck

  doctest Collidex.Detection.Rects
  alias Collidex.Detection.Rects
  alias Collidex.Geometry.Rect

  def make_fixtures do
    %{
      a: Rect.make(1,1,-1,-1),
      b: Rect.make(1,1,2,2),
      c: Rect.make(0.5,-0.5,1.5,0.5),
      d: Rect.make(-2,-0.75,2,-2),
      e: Rect.make(-2,2,-0.5,0.5),
      f: Rect.make(3,-3,-3,3),
      g: Rect.make(2,0.5,3,-0.5),
      h: Rect.make(-1,-3,1,-2),
      i: Rect.make(-1.5,1,-2.5,0),
    }
  end

  describe "rect to rect collisions" do
    it "can detect colliding rects" do
      fixtures = make_fixtures
      assert {:collision, _} = Rects.collision?(fixtures.a, fixtures.b)
      assert {:collision, _} = Rects.collision?(fixtures.a, fixtures.c)
      assert {:collision, _} = Rects.collision?(fixtures.a, fixtures.d)
      assert {:collision, _} = Rects.collision?(fixtures.a, fixtures.e)
      assert {:collision, _} = Rects.collision?(fixtures.a, fixtures.f)
    end
    it "can detect non-colliding rects" do
      fixtures = make_fixtures
      refute Rects.collision?(fixtures.a, fixtures.g)
      refute Rects.collision?(fixtures.a, fixtures.h)
      refute Rects.collision?(fixtures.a, fixtures.i)
      refute Rects.collision?(fixtures.d, fixtures.g)
    end
  end
end
