defmodule FileGameRepositoryTest do
  use ExUnit.Case

  setup do
    {:ok, repo: FileGameRepository}
  end

  test "repo.put(game) inserts a new game", %{repo: repo} do
    expected = %Game{name: "test", score: 100, difficulty: :medium}

    assert :ok == repo.put!(expected)

    [actual | _ ] = repo.list!()

    assert expected.name == actual.name
    assert expected.score == actual.score
    assert expected.difficulty == actual.difficulty
  end

end
