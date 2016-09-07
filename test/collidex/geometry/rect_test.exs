defmodule TestRect do
  use ExSpec, async: true

  doctest Collidex.Geometry.Rect
  alias Collidex.Geometry.Rect

  describe "make" do
    context "from a 3-tuple" do
      it "makes a Rect from floats" do
        rect = Rect.make({0.0, 0.0, 1.0, 1.0})
        assert is_map(rect) == true
        assert rect == %Rect{ a: %{ x: 0.0, y: 0.0 }, b: %{x: 1.0, y: 1.0} }
      end

      it "makes a Rect from ints" do
        rect = Rect.make({0, 0, 1, 1})
        assert is_map(rect) == true
        assert rect == %Rect{ a: %{ x: 0.0, y: 0.0 }, b: %{x: 1.0, y: 1.0} }
      end

      it "fails to make a Rect from strings" do
        assert_raise(FunctionClauseError, fn -> Rect.make({ 1, "a","c","foo"}) end)
      end
    end

    context "from three arguments" do
      it "makes a Rect from floats" do
        rect = Rect.make(0.0, 0.0, 1.0, 1.0)
        assert is_map(rect) == true
        assert rect == %Rect{ a: %{ x: 0.0, y: 0.0 }, b: %{x: 1.0, y: 1.0} }
      end

      it "makes a Rect from ints" do
        rect = Rect.make(0, 0, 1, 1)
        assert is_map(rect) == true
        assert rect == %Rect{ a: %{ x: 0.0, y: 0.0 }, b: %{x: 1.0, y: 1.0} }
      end

      it "fails to make a Rect from strings" do
        assert_raise(FunctionClauseError, fn -> Rect.make( 3, "a", "c", "foo") end)
      end
    end
  end
end
