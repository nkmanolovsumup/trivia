defmodule Trivia do

  defmodule Repo do
    @behaviour GameRepository

    def list!(), do: {:error, :not_implemented}
    def get_by!(_), do: {:error, :not_implemented}
    def put!(_), do: :mocked_ok
    def delete!(_), do: {:error, :not_implemented}
  end

  defmodule CLI do
    def main([number]), do: main([number, "medium"])

    def main([number, difficulty | _]) do
      {number, name} = case number do
        "challenge" -> 
          name = IO.gets("What is your name? ")
          {10, String.trim(name)}
        number -> 
          number = String.to_integer(number)
          {number, "undefined"}
      end
      difficulty = String.to_atom(difficulty)
      for question <- Trivia.fetch(number, difficulty) do
        IO.puts question.question
        for {number, answer} <- question.answers do
          IO.puts "#{number}. #{answer}"
        end
        input = IO.gets("what is your number? ")
                |> String.trim()
                |> String.to_integer()
        IO.puts ""
        if Trivia.answer(question, input), do: 10, else: 0
      end
      |> Enum.sum()
      |> maybe_append(name, difficulty)
      |> IO.inspect
    end

    defp maybe_append(_score, "undefined", _difficulty), do: :ok
    defp maybe_append(score, name, difficulty), do: 
      %Game{name: name, score: score, difficulty: difficulty}
      |> Trivia.Repo.put!()
  end

  def fetch(amount, difficulty) do
    url = "https://opentdb.com/api.php?amount=#{amount}&type=multiple&category=9&difficulty=#{difficulty}"
    case :hackney.get(url, [], "", [with_body: true]) do
      {:ok, 200, _, body} -> 
        Jason.decode!(body)["results"]
        |> Enum.map(&create_questions/1)
      _ -> :error
    end
  end

  def answer(%{correct: {index, _}} = _question, index), do: true
  def answer(_, _), do: false

  defp create_questions(%{"question" => question,
                          "correct_answer" => correct,
                          "incorrect_answers" => incorrect}) do
    answers = Enum.shuffle([correct | incorrect])
    answers = Enum.zip(1..length(answers), answers)
    %{question: question, 
      answers: answers,
      correct: Enum.find(answers, fn({_idx, answer}) -> answer == correct end)
    }
  end
end
