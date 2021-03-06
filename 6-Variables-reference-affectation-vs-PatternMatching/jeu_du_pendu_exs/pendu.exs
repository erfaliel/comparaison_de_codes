
"""
  Experiment in progress…
"""
# Paramètre du nombre de coup avant que je joeur ne perde
count = 12

  # Liste des mots à trouver, proposés par le jeu.
game_words_list = [
  "nez",
  "jet",
  "jeu",
  "zoo",
  "fer",
  "dos",
  "riz",
  "tir",
  "emu",
  "abus",
  "ados",
  "banc",
  "bile",
  "brut",
  "brai",
  "chat",
  "demo",
  "deco",
  "dodu",
  "aimer",
  "verge",
  "video",
  "vitre",
  "abusif",
  ]

defmodule Pendu do
  
  def loop_game([word: game_word_string, user_word: _, found_letters: _, count: count]) do
    IO.puts("! GAME OVER ! «« Le mot à trouver était #{game_word_string} !")
  end

  def loop_game([word: game_word_string, user_word: word_research_string, found_letters: _, count: _])
    when game_word_string == word_research_string do
       IO.puts("! Vous avez gagner avec le mot #{game_word_string}")
  end

  def loop_game(user_game_kl) do
    # write the game code here
    get_char()
    |> check_char_on_word([word: game_word_string, found_letters: found_letters_list, count: attempts])
    |> loop_game()

  end
  """
    for the docString:
    iex(81)> [found_letters: found_letters_list, count: attempts] = Pendu.check_char_on_word(game_word_string, "e", [found_letters: found_letters_list, count: attempts])
    [found_letters: ["e", "l"], count: 6]
    iex(82)> [found_letters: found_letters_list, count: attempts] = Pendu.check_char_on_word(game_word_string, "e", [found_letters: found_letters_list, count: attempts])
    [found_letters: ["e", "l"], count: 7]
    iex(83)> [found_letters: found_letters_list, count: attempts] = Pendu.check_char_on_word(game_word_string, "a", [found_letters: found_letters_list, count: attempts])
    [found_letters: ["a", "e", "l"], count: 7]
  """
  def check_char_on_word( char, [word: game_word_string, found_letters: found_letters_list, count: attempts]) do
    cond do
      (String.contains?(game_word_string, char)) and not (char in found_letters_list)
        -> [word: game_word_string, found_letters: [char | found_letters_list], count: attempts]
      true
        -> [word: game_word_string, found_letters: found_letters_list, count: (attempts + 1)]
    end
  end

  def write_word_string(game_word_string, found_letters_list) do
    String.codepoints(game_word_string)
    |> Enum.map(fn n_char -> check_char(found_letters_list, n_char) end)
    |> to_string
  end

  def check_char(found_letters_list, n_char) do
    cond do
      n_char in found_letters_list -> n_char
      true                         -> "*"
    end
  end

  def get_char do
    user_char = IO.gets("Veuillez entrer un caractère et un seul : ")
    |> String.trim_trailing
    |> String.downcase
    
    cond do
      Regex.match?(~r{^[a-zA-Z]$}, user_char) -> user_char
      true                                    -> get_char()
    end
  end
end
game_word_string = Enum.random(game_words_list)
found_letters_list = []
word_research_string = "" 
attempts = 0

user_game_kl = [word: game_word_string, user_word: word_research_string, found_letters: found_letters_list, count: attempts]

Pendu.loop_game(user_game_kl)
