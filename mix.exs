defmodule FeedEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :feed_ex,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler, "~> 0.28.0"},
      {:rustler_precompiled, "~> 0.6"},
      {:httpoison, "~> 1.8"}
    ]
  end
end
