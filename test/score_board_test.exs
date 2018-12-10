defmodule Trivia.ScoreBoardTest do
  use ExUnit.Case, async: false

  alias Trivia.ScoreBoard

  @difficulties [:medium, :hard, :easy]

  describe "Read and list players" do
    test "Make sure data is correctly listed" do
      {:ok, all_players} = ScoreBoard.get_all()
      Enum.each(all_players, fn player ->
        assert Enum.member?(@difficulties, player.difficulty)
        assert player.score >= 0
        assert is_binary(player.name) == true
      end)
    end
  end

  test "Players are group by difficulty and score (hard to easy)" do
    expected = %{
      hard: [%Game{difficulty: :hard, score: 10, name: "player10"},
             %Game{difficulty: :hard, score: 4, name: "player5"}],
      medium: [%Game{difficulty: :medium, score: 8, name: "player3"}],
      easy: [%Game{difficulty: :easy, score: 6, name: "player8"}]
    }
    assert ScoreBoard.group() == {:ok, expected}
  end
end
