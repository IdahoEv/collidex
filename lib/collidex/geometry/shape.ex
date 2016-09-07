defmodule Collidex.Geometry.Shape do
  @moduledoc """
      This module defines the the behavior common to all shapes used
      by the collision engine.
      """

  @doc """
  Returns the center (or centroid, if applicable) of the shape as
  an {x, y} 2-tuple.
  """
  @callback center :: tuple
end