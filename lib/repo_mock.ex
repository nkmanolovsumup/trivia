defmodule Trivia.RepoMock do

  # List all records
  def list! do
    {:ok, [
        %Game{difficulty: :hard, score: 10, name: "player10"},
        %Game{difficulty: :easy, score: 6, name: "player8"},
        %Game{difficulty: :medium, score: 8, name: "player3"},
        %Game{difficulty: :hard, score: 4, name: "player5"},
    ]}
  end

  # Get by name
  def get_by!(name) when is_binary(name) do
    {:ok, %Game{difficulty: :medium, score: 8, name: "player3"}}
  end
end
