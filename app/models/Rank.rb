module Rank
    rank = Struct.new(:name, :short, :score)
  
    TWO = rank.new("two", "2", 1)
    THREE = rank.new("three", "3", 2)
    FOUR = rank.new("four", "4", 3)
    FIVE = rank.new("five", "5", 4)
    SIX = rank.new("six", "6", 5)
    SEVEN = rank.new("seven", "7", 6)
    EIGHT = rank.new("eight", "8", 7)
    NINE = rank.new("nine", "9", 8)
    TEN = rank.new("ten", "10", 9)
    JACK = rank.new("jack", "j", 10)
    QUEEN = rank.new("queen", "q", 11)
    KING = rank.new("king", "k", 12)
    ACE = rank.new("ace", "a", 13)
  
    ALL = [
      TWO, THREE, FOUR, FIVE, SIX, 
      SEVEN, EIGHT, NINE, TEN, 
      JACK, QUEEN, KING, ACE
  ]

  def from_str(short:)
    ALL.find{|rank| rank.short == short}
  end
end