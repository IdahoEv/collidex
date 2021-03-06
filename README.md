# Collidex

[![Build Status](https://travis-ci.org/IdahoEv/collidex.svg?branch=master)](https://travis-ci.org/IdahoEv/collidex)
[![Coverage Status](https://coveralls.io/repos/github/IdahoEv/collidex/badge.svg?branch=master)](https://coveralls.io/github/IdahoEv/collidex?branch=master)
[![Hex.pm](https://img.shields.io/hexpm/v/collidex.svg)](https://hex.pm/packages/collidex)

Collidex is an in-development 2D geometry collision detection library in pure
Elixir. It supports circles, grid-aligned rectangles, and convex polygons. When
comparing two shapes, it will prefer the fastest algorithm that can test both.

For testing arbitrary convex polygons, Collidex has two available algorithms.
A fully accurate collision detector will use the Separating Axis Theorem to
check if the polygons collide.  An additional fast checker is available that
will detect most collisions and separations. In most usages it has significantly
better performance but at the cost of a few false positives in some cases of
near misses between acute polygons.

## Usage

### Points

Cartesian points are 2-tuples of the form {x, y}. I picked this format for
speed and for compatibility with [certrel/graphmath](https://hex.pm/packages/graphmath).

### Geometric primitives

Circles, Rects (grid-aligned rectangles), and Polygons are Elixir structs.
Each module has a make() function for creating them in common formats.

#### `Circle`s
Circles can be made from three arguments (center_x, center_y, radius), or a
3-tuple specifying the same values.

```
iex> Collidex.Geometry.Circle.make(0.0, 0.0, 1.0)
%Collidex.Geometry.Circle{center: {0.0, 0.0}, radius: 1.0}

iex> Collidex.Geometry.Circle.make(1.0, 1.0, 1.0)
%Collidex.Geometry.Circle{center: {1.0, 1.0}, radius: 1.0}
```

#### `Rect`s

Rects are grid-aligned rectangles delineated by two opposite corners.
`Rect.make` takes a pair of vectors:

```
iex(1)> Collidex.Geometry.Rect.make({0.0, 0.0}, {1.0, 1.0})
%Collidex.Geometry.Rect{a: {0.0, 0.0}, b: {1.0, 1.0}}
```

For convenience, you may omit the braces and just specify four numbers:
```
iex(2)> Collidex.Geometry.Rect.make(0.0, 0.0, 1.0, 1.0)
%Collidex.Geometry.Rect{a: {0.0, 0.0}, b: {1.0, 1.0}}
```

#### `Polygon`s

Specify polygons as an array of vectors:

```
iex(3)> Collidex.Geometry.Polygon.make([{0.0, 0.0}, {1.0, 1.0}, {2.0, 0.0}, {1.0, -1.0}])
%Collidex.Geometry.Polygon{vertices: [{0.0, 0.0}, {1.0, 1.0}, {2.0, 0.0},
  {1.0, -1.0}]}
```

### Detecting Collisions Between primitives

Pass any pair of geometric shapes, as represented by Collidex structs, to
`Collidex.Detector.collision?/3`. A truthy return value indicates that they
overlap on the plane. The third argument is an optional atom representing the
detection method for Polygon-to-Polygon collisions and defaults to `:accurate`.
For faster but less accurate comparisons, specify `:fast`.  See details
in the docs for `Collidex.Detector.Polygons`.

### Detecting collisions between and within lists of primitives

Checking for collisions between lists of geometric shapes:

```
Collidex.ListDetector.find_collisions(list_1, list_2, method \\ :accurate)
```

Will return a list of 3-tuples of the form `{ shape_1, shape_2, _ }` representing
pairs of shapes that intersect on the plane.

For collisions between elements of a single list, use 'find_collisions_within/2':

```
Collidex.ListDetector.find_collisions_within(list, method \\ :accurate)
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  Add `collidex` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:collidex, "~> 0.1.1"}]
    end
    ```

## License

MIT License, see LICENSE file.
