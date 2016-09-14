defmodule Collidex.Mixfile do
  use Mix.Project

  def project do
    [app: :collidex,
     version: "0.1.0",
     elixir: "~> 1.3.0",
     description: description,
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     test_coverage: [ tool: ExCoveralls ],
     preferred_cli_env: [coveralls: :test]
   ]
  end

  defp description do
    """
    A 2-D collision detection library implemented in pure Elixir.
    Supports circles, polygons, and grid-aligned rectangles.
    """
  end

  defp package do
    [
      name: :collidex,
      files: ["lib", "mix.exs"],
      maintainers: ["Evan Dorn"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/idahoev/collidex"

      }
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      { :graphmath, "~> 1.0.2" },
      { :ex_doc, "~> 0.12", only: :dev },
      { :triq, github: "triqng/triq", only: :test},
      { :ex_spec, ">= 0.0.0", only: :test },
      { :mix_test_watch, "~> 0.2", only: :dev},
      { :excoveralls, "~> 0.5", only: :test },
      { :inch_ex, "~> 0.5.3", only: :docs},
      { :markdown, github: "devinus/markdown"}
    ]
  end

end
