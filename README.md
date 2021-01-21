# README

A Monte Carlo-like simulation app in which a user can run through a set number of poker scenarios while holding certain deals constant. For example, assuming a universe in which I sat down at a table of 6 players and I was always dealt a 2 of Hearts and a 4 of Clubs, how many rounds would I end up winning? What if the Flop included a Jack of Spades? The app allows you to set the cards you'd like to hold constant, number of players at the table, as well as number of rounds you'd like the simulation to run through.

## Running a Local Version

## Running the test suite

## Logic

### Hand Identification

Hand identification does not identify the best MetaHand, but all MetaHands that could possibly be made from a Hand.


## Terminology

*metahand*

Describes the types of hands one could potentially have. Includes, in order of value:

1. Royal Flush
2. Straight Flush
3. Four of a Kind
4. Full House
5. Flush
6. Straight
7. Three of a Kind
8. Two Pair
9. One Pair
10. High Card

*hand*

Describes all cards availible for play for a particular user. Includes both the holes (cards in a players possession) as well as the community cards. This is a slight adjustment to the typical definition of a hand in poker, which only describes the 5 cards that could potentially be a playable MetaHand. We include all 7 because we're looking for the full range of possible hands which may include two different combinations of 5 cards.

*hole*

The list of two cards a player holds in his or her hand.

*community cards*

The list of cards on the table for all players to use. For example, the Flop, the Turn, and the River are all considered Community Cards.

*flop*

The Flop is the list of 3 cards first dealt to the table.

*turn* 

The Turn is the single card dealt to the table after the Flop.

*river*

The River is the single card dealt to the table after the Turn. 

*burned cards*

The list of cards that have been burned in between dealings