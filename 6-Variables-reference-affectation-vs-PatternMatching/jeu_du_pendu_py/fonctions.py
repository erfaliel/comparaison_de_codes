import random
import re
import pickle

def generate_word_to_find(game_list):
  """Take a list and return a tuple.
  from a list, extract a word by random fonction, change this word into a list and the number of
  the char for this one."""

  word_to_find_char = random.choice(game_list)
  number_word_to_find_int = len(word_to_find_char)
  word_to_find_list = [char for char in word_to_find_char]
  return (word_to_find_list, number_word_to_find_int)

def getchar():
  """ return a char entered by the user if it is one char only. """
  char = ''
  while re.match(r"^[a-zA-Z]$", char) is None : # other: if len(char)>1 or not char.isalpha():
    char = input("Entrez un caractère et un seul : ")
  return char

def check_char(searched_word_list, word_to_find_list, user_char):
  """Take two list and a char and return the modified first list.
  the fonction allowed to check if user_char is in word_to_find_list.
  So it sets the char in the correct slot of the searched_word_list. """

  for (index, element) in enumerate(word_to_find_list):
    if element == user_char :
      searched_word_list[index] = user_char
  return searched_word_list

def word_user_init(number_word_to_find_int):
  """Take an integer and return a list.
  form integer, generate a list of '*'. """ 

  searched_word_list = list()
  i = 0
  while i < number_word_to_find_int :
    searched_word_list.append('*')
    i += 1
  return searched_word_list
# Score management
scores_dict = {}
def get_scores():
  """return a dict.
  read the binary dict file, creat it, if it does not exist. """
  try: # Check is file exist
    with open('scores', 'rb') as scores_file:
      score_depickler = pickle.Unpickler(scores_file)
      scores_dict = score_depickler.load()
   
  except FileNotFoundError:
    save_scores({'Player1': 0})
    return scores_dict
  else:
    return scores_dict

def save_scores(scores_dict) :
  """Take a dict, return nothing.
  record a dict in a binary file. """
  with open('scores', 'wb') as scores_file:
    scores_pickler = pickle.Pickler(scores_file)
    scores_pickler.dump(scores_dict)

def get_score_player(scores_dict, player_name_string):
  """Take a dict and string, return a tuple: (string, int)
  get the tuple player name, player score in the scores_dict. """
  if player_name_string not in scores_dict:
    scores_dict[player_name_string] = 0
  # return score_player_tuple
  return (player_name_string, scores_dict[player_name_string])

def calculate_score_player(score_player_tuple, score_int):
  """Take a tuple and int, return a tuple.
  Rule for calculate the new score for the player.
  Rule is last score + new score. """
  player_name_string, score_player_int = score_player_tuple
  return (player_name_string, score_player_int + score_int)

# Unit tests 
if __name__ == "__main__" :
  game_list = ['toto', 'otot']
  (word_to_find_list, number_word_to_find_int) = generate_word_to_find(game_list)
  print(word_to_find_list)
  print(number_word_to_find_int)
  searched_word_list = word_user_init(number_word_to_find_int)
  print(searched_word_list)
  print(check_char(searched_word_list, word_to_find_list, 'o'))
  scores_dict = {
    "titi": 3,
    "tata": 4
  }
  print(get_score_player(scores_dict, "titi"))
  print(get_score_player(scores_dict, "toto"))
  print(calculate_score_player(("Toto", 0), 2))
  