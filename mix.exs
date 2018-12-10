defmodule Trivia.MixProject do
  use Mix.Project

  def project do
    [
      app: :trivia,
      version: "0.0.1",
      escript: escript(),
      deps: deps(),
    ]
  end

  defp deps do
    [
      {:hackney, "~> 1.14"},
      {:jason, "~> 1.1"},
      {:poison, "~> 3.1"}
    ]
  end

  def escript do
    [main_module: Trivia.CLI]
  end
end
