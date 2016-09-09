defmodule Collidex.Detection.Rects do

  def collision?(r1, r2) do
    { r1x1, r1y1 } = r1.a
    { r1x2, r1y2 } = r1.b
    { r2x1, r2y1 } = r2.a
    { r2x2, r2y2 } = r2.b

    x_overlap =
         in_range?(r1x1, r2x1, r2x2)
      or in_range?(r1x2, r2x1, r2x2)
      or in_range?(r2x1, r1x1, r1x2)
      or in_range?(r2x2, r1x1, r1x2)

    y_overlap =
         in_range?(r1y1, r2y1, r2y2)
      or in_range?(r1y2, r2y1, r2y2)
      or in_range?(r2y1, r1y1, r1y2)
      or in_range?(r2y2, r1y1, r1y2)

    cond do
      x_overlap and y_overlap ->
        { :collision, "todo_provide_vector" }
      true ->
        false
    end
  end

  @doc """
  True if a is beween b and c, inclusive
  """
  defp not_between?(a,b,c) do
    ((a > b and a > c) or (a < b and a < c))
  end

  defp in_range?(a,b,c) when b > c do
    in_range?(a,c,b)
  end

  defp in_range?(a,b,c) do
    a >= b and a <= c
  end
end
