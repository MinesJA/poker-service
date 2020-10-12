module Rank
    rank = Struct.new(:name, :score)
  
    TWO = rank.new("two", 1)
    THREE = rank.new("three",2)
    FOUR = rank.new("four", 3)
    FIVE = rank.new("five", 4)
    SIX = rank.new("six", 5)
    SEVEN = rank.new("seven", 6)
    EIGHT = rank.new("eight", 7)
    NINE = rank.new("nine", 8)
    TEN = rank.new("ten", 9)
    JACK = rank.new("jack", 10)
    QUEEN = rank.new("queen", 11)
    KING = rank.new("king", 12)
    ACE = rank.new("ace", 13)
  
    ALL = [
      TWO, THREE, FOUR, FIVE, SIX, 
      SEVEN, EIGHT, NINE, TEN, 
      JACK, QUEEN, KING, ACE
    ]
  end