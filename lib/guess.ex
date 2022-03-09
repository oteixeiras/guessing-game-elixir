defmodule Guess do
  use Application

  def start(_,_) do
    run()
    {:ok, self()}
  end

  def run() do
    IO.gets("Select dificult level: 1, 2 or 3: ")
    |> parse_input()
    |> pickup_number()
    |> play()
  end

  def play(picked_num) do
    IO.gets("what's the number drawn?")
    |> parse_input()
    |> guess(picked_num, 1)
  end

  def guess(usr_guess, picked_num, count) when usr_guess > picked_num do
    IO.gets("-lowest kick: ")
    |> parse_input()
    |> guess(picked_num, count+1)
  end

  def guess(usr_guess, picked_num, count) when usr_guess < picked_num do
    IO.gets("+ highest kick: ")
    |> parse_input()
    |> guess(picked_num, count+1)
  end

  def guess(_, _, count) do
    IO.puts("*** you won with #{count} guesses****")
    show_score(count)
  end

  def show_score(guesses) when guesses > 6 do
    IO.puts("status : #Bad...")
  end

  def show_score(guesses) do
    {_, msg} = %{1..1 => "status :#great!!!",
                 2..3 => "status :#good!",
                 4..6 => "status :#reasonable."}
    |> Enum.find(fn {range, _} ->
      Enum.member?(range, guesses)
    end)
    IO.puts(msg)
  end

  def parse_input(:error) do
    IO.puts("Invalid input!!")
    run()
  end

  def parse_input({num, _}) do
    num
  end

  def parse_input(date) do
    date
    |> Integer.parse()
    |> parse_input()
  end

  def pickup_number(level) do
    level
    |> get_range()
    |> Enum.random()
  end

  def get_range(level) do
    case level do
      1 -> 1..10
      2 -> 1..100
      3 -> 1..1000
      _ -> IO.puts("invalid level!!")
      run()
    end
  end

end
