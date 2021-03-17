# Poker Simulation API

A Monte Carlo-like simulation app in which a user can run through a set number of poker scenarios while holding certain deals constant. For example, assuming a universe in which I sat down at a table of 6 players and I was always dealt a 2 of Hearts and a 4 of Clubs, how many rounds would I end up winning? What if the Flop included a Jack of Spades? The api allows you to set the cards you'd like to hold constant, number of players at the table, as well as number of rounds you'd like the simulation to run through.

# Using the API

### Game Route
Game route allows you to dictate how many round to run through, how many players to play a game, what the starting holes are for any one or many players, and what community cards to set (flop, turn, or river).

`/game`

##### Body
```
  {
      "run_count": 10000,
      "player_count": 6,
      "holes": {"1": ["KD", "3D"]},
      "community": {"flop": ["4D", "5C", "JS"]}
  }
```
