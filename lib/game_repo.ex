defmodule GameRepository do

  @callback list!() :: [Game.t]
  @callback get_by!(Keyword.t | map()) :: Game.t
  @callback put!(Game.t) :: :ok | {:error, term}
  @callback delete!(Game.t) :: :ok | {:error, term}

end
