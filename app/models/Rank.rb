class Rank < Enum
  meta_attr :short, :score

  enum_attr :TWO, "2", 1
  enum_attr :THREE, "3", 2
  enum_attr :FOUR, "4", 3
  enum_attr :FIVE, "5", 4
  enum_attr :SIX, "6", 5
  enum_attr :SEVEN, "7", 6
  enum_attr :EIGHT, "8", 7
  enum_attr :NINE, "9", 8
  enum_attr :TEN, "10", 9
  enum_attr :JACK, "j", 10
  enum_attr :QUEEN, "q", 11
  enum_attr :KING, "k", 12
  enum_attr :ACE, "a", 13
  
  def self.from_str(short)
    self.all.find{|rank| rank.short == short}
  end
  
end