
def toServe(playerTuple, sumOfPoints, game):
  """
  The first player in arg playerTuple started serving
  sumOfPoints of the current game
  first game is 1
  """

  if sumOfPoints < 20:
    # First player if even
    player = int(sumOfPoints / 2) % 2
  else:
    player = sumOfPoints % 2

  # Every other game server changes
  player = player + game - 1
  return playerTuple[player%2]


print("aufschlag.toServe(('Tom','Sepp'), 0, 1)")
