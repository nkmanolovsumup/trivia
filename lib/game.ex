defmodule Game do

  defstruct id: 0, name: "", score: 0, difficulty: nil

  @type difficulty :: :easy | :medium | :hard
  @type t :: %Game{
    id: Integer.t,
    name: String.t,
    score: Integer.t,
    difficulty: difficulty
  }

end
