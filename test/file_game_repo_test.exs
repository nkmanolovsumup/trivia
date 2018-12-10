defmodule FileGameRepositoryTest do
  use ExUnit.Case, async: false

  setup do
    FileGameRepository.init()
    {:ok, repo: FileGameRepository}
  end

  test "repo.list!() returns empty list when nothing is stored", %{repo: repo} do
    assert length(repo.list!()) == 0
  end

  test "repo.put(game) inserts a new game", %{repo: repo} do
    assert length(repo.list!()) == 0

    expected = %Game{name: "test", score: 100, difficulty: :medium}

    assert :ok == repo.put!(expected)

    [actual | _ ] = repo.list!()

    assert expected.name == actual.name
    assert expected.score == actual.score
    assert expected.difficulty == actual.difficulty
  end

end
