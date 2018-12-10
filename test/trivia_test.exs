defmodule TriviaTest do
  use ExUnit.Case

  doctest Trivia

  test "fetch some number of questions with choosen diffuculty" do
    number = 10
    assert length(Trivia.fetch(number, :medium)) == number
  end

  test "uniqness of questions" do
    number = 10
    assert length(Enum.uniq(Trivia.fetch(number, :medium))) == number
  end

  test "answer" do
    question =   %{
      answers: [
        {1, "Kirstine Christiansen"},
        {2, "Ole Kirk Christiansen"},
        {3, " Gerhardt Kirk Christiansen"},
        {4, " Jens Niels Christiansen"}
      ],
      correct: {2, "Ole Kirk Christiansen"},
      question: "Who is the founder of &quot;The Lego Group&quot;?"
    }
    assert Trivia.answer(question, 2)
    refute Trivia.answer(question, 3)
  end
end
