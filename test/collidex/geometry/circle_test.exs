defmodule TestCircle do
  use ExSpec, async: true

  doctest Collidex.Geometry.Circle
  alias Collidex.Geometry.Circle

  describe "make" do
    context "from a 3-tuple" do
      it "makes a circle from floats" do
        circle = Circle.make({0.0,0.0,1.0})
        assert is_map(circle) == true
        assert circle == %Circle{ center: { 0.0, 0.0 }, radius: 1.0 }
      end

      it "makes a circle from ints" do
        circle = Circle.make({0,0,1})
        assert is_map(circle) == true
        assert circle == %Circle{ center: { 0.0, 0.0 }, radius: 1.0 }
      end

      it "fails to make a circle from strings" do
        assert_raise(FunctionClauseError, fn -> Circle.make({ "a","c","foo"}) end)
      end
    end

    context "from three arguments" do
      it "makes a circle from floats" do
        circle = Circle.make(0.0,0.0,1.0)
        assert is_map(circle) == true
        assert circle == %Circle{ center: { 0.0, 0.0 }, radius: 1.0 }
      end

      it "makes a circle from ints" do
        circle = Circle.make(0,0,1)
        assert is_map(circle) == true
        assert circle == %Circle{ center: { 0.0, 0.0 }, radius: 1.0 }
      end

      it "fails to make a circle from strings" do
        assert_raise(FunctionClauseError, fn -> Circle.make( "a","c","foo") end)
      end
    end
  end
end
