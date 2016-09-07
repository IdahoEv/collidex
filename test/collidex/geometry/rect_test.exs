defmodule TestRect do
  use ExSpec, async: true

  doctest Collidex.Geometry.Rect
  alias Collidex.Geometry.Rect

  describe "make" do
    context "from a 3-tuple" do
      it "makes a Rect from floats" do
        rect = Rect.make({0.0, 0.1, 1.0, 1.1})
        assert is_map(rect) == true
        assert rect == %Rect{ a: { 0.0, 0.1 }, b: { 1.0, 1.1} }
      end

      it "makes a Rect from ints" do
        rect = Rect.make({0, 1, 2, 3})
        assert is_map(rect) == true
        assert rect == %Rect{ a: { 0.0, 1.0 }, b: {2.0, 3.0} }
      end

      it "fails to make a Rect from strings" do
        assert_raise(FunctionClauseError, fn -> Rect.make({ 1, "a","c","foo"}) end)
      end
    end

    context "from three arguments" do
      it "makes a Rect from floats" do
        rect = Rect.make(0.0, 0.0, 1.0, 1.0)
        assert is_map(rect) == true
        assert rect == %Rect{ a: { 0.0, 0.0 }, b: {1.0, 1.0} }
      end

      it "makes a Rect from ints" do
        rect = Rect.make(0, 0.2, 1, 1.5)
        assert is_map(rect) == true
        assert rect == %Rect{ a: {0.0, 0.2 }, b: {1.0, 1.5} }
      end

      it "fails to make a Rect from strings" do
        assert_raise(FunctionClauseError, fn -> Rect.make( 3, "a", "c", "foo") end)
      end
    end
  end

  describe "center" do
    it "returns the average of the points" do
      assert { 0.0, 0.0 } = Rect.center(Rect.make({ 1,1, -1, -1}))

      # Use some numbers with floating point rounding problems
      {x, y} = Rect.center(Rect.make({ 2, -3.3, -3.66, 4.1}))
      assert_in_delta(x, -0.83, 0.00001)
      assert_in_delta(y, 0.40, 0.00001)
    end
  end
end
