defmodule Trivia.ScoreBoard do
  alias Trivia.RepoMock

  def get_all do
    RepoMock.list!()
  end

  # Group by difficulty and score
  def group do
    {:ok, games} = get_all()

    grouped_by_difficulty = Enum.group_by(games, fn game -> game.difficulty end)
    sort_by_score = fn games ->
      games
      |> Enum.sort_by(fn game -> game.score end)
      |> Enum.reverse()
    end
    all = [sort_by_score.(grouped_by_difficulty[:hard]),
           sort_by_score.(grouped_by_difficulty[:medium]),
           sort_by_score.(grouped_by_difficulty[:easy])]
    {:ok, List.flatten(all)}
  end
end
