defmodule Collidex.Geometry.Rect do
  @moduledoc """
  Struct to represent grid-aligned rectangles as a pair of points (A and B).
  """
  defstruct a: { 0.0, 0.0},
            b: { 0.0, 0.0}

  @doc """
  Make a Rect. Numbers are coerced to floats.  Accepts any of:
    * Four arguments: e.g. x1, y1, x2, y2
    * Two vertices as 2-tuples: e.g. { x1, y1}, {x2, y2}
    * A 4-tuple: e.g. { x1, y1}, {x2, y2}

  ## Examples

  ```
  iex> Collidex.Geometry.Rect.make( 1, 2, 50.1, 51.1 )
  %Collidex.Geometry.Rect{a: {1.0, 2.0}, b: { 50.1, 51.1}}

  iex> Collidex.Geometry.Rect.make({ 1, 2}, { 50.1, 51.1 })
  %Collidex.Geometry.Rect{a: {1.0, 2.0}, b: { 50.1, 51.1}}

  iex> Collidex.Geometry.Rect.make({ 1, 2, 50.1, 51.1 })
  %Collidex.Geometry.Rect{a: {1.0, 2.0}, b: { 50.1, 51.1}}
  
  ```
  """
  def make({ x1, y1, x2, y2 }), do: make({x1, y1}, {x2, y2})

  def make({ x1, y1}, { x2, y2 })
    when is_number(x1)
      and is_number(y1)
      and is_number(x2)
      and is_number(y2)
  do
    %__MODULE__{  a: Collidex.Utils.coerce_floats({ x1, y1}),
                  b: Collidex.Utils.coerce_floats({ x2, y2}),
                }
  end

  def make( x1, y1, x2, y2 ), do: make {x1, y1}, {x2, y2}

  @doc """
  Return the geometric center of a rect as a 2-tuple.
  """
  def center(%__MODULE__{ a: { x1, y1}, b: { x2, y2 }}) do
    {(x1 + x2)/2.0, (y1 + y2)/2.0}
  end
end
