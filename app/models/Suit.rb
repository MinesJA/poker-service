class Suit < Enum
    meta_attr :short

    enum_attr :CLUBS, "c"
    enum_attr :DIAMONDS, "d"
    enum_attr :SPADES, "s"
    enum_attr :HEARTS, "h"

    def self.from_str(short)
        self.all.find{|suit| suit.short == short}
    end
end