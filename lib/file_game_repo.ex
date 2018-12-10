defmodule FileGameRepository do
  @behaviour GameRepository

  @storage Application.get_env(:trivia, :filepath, "games.json")

  def init() do
    File.write(filepath, Poison.encode!([]), [:write])
  end

  defp filepath do
    [:code.priv_dir(:trivia), @storage]
    |> Path.join()
  end

  def list!() do
    games =
      filepath
      |> File.read!
      |> Poison.decode!(as: [%Game{}])
      |> Enum.map(fn(game) -> %{game | difficulty: String.to_atom(game.difficulty)} end)
  end

  def get_by!([{key, value}]) do
    list!() |> Enum.find(&(Map.get(&1, key) == value))
  end

  def put!(game) do
    games = list!()
    latest_id =
      case games do
        [] -> 1
        [%Game{id: id} | _] -> id
      end

    games = [Map.put(game, :id, latest_id + 1) | games]
    games = Poison.encode!(games)

    filepath |> File.write(games)
  end

  def delete!(_game) do
    {:error, :not_implemented}
  end

end
