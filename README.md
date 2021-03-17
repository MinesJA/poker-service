# Poker Simulation API

## General

A Monte Carlo-like simulation app in which a user can run through a set number of poker scenarios while holding certain deals constant. For example, assuming a universe in which I sat down at a table of 6 players and I was always dealt a 2 of Hearts and a 4 of Clubs, how many rounds would I end up winning? What if the Flop included a Jack of Spades? The api allows you to set the cards you'd like to hold constant, number of players at the table, as well as number of rounds you'd like the simulation to run through.

## Using the API

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
##### Returns
```
  [
    {
      "holes": {
        "1": ["6S", "JH"], 
        ...
      },
      "community": {
        "flop": ["3S", "KH", "KC"],
        "turn": ["KS"],
        "river": ["AD"]
      },
      "deal_hands": {
        "1": {
          "type": "high_card",
          "cards": ["JH"],
          "kickers": ["6S"]
        },
        ...
      },
      "flop_hands": {
        "1": {
          "type": "pair",
          "cards": ["KC", "KH"],
          "kickers": ["JH", "6S", "3S"]
        },
        ...
       
      },
      "turn_hands": {
        "1": {
            "type": "three_kind",
            "cards": ["KS", "KC", "KH"],
            "kickers": ["JH"]
        },
        ...
        },
        "river_hands": {
            "1": {
                "type": "full_house",
                "cards": ["KS","KC","KH","JS","JH"],
                "kickers": []
            }, 
        ...
        }
    },
    ...
  ]
```



## To Do:
1. Make executions run in parralel using Forks (10,000 runs currently returns in postman in 37s)
2. Save results of run to a database
3. Figure out way to reduce json output while still being useful (10,000 runs is currently 17.61mb of data)
4. Add statistical analysis via a python service running regressions.
