require_relative "../utils/array"

module IdentificationService


    # 1. Royal Flush
        # 5 cards
        # Rank Seq
        # Suit Match
    # 2. Straight Flush
        # 5 cards
        # Rank Seq
        # Suit Match
    # 3. Four Kind
        # 4 cards
        # Rank Match
    # 4. Full House
        # 5 cards
        # Rank Match
    # 5. Flush
        # 5 cards
        # Suit Match
    # 6. Straight
        # 5 cards
        # Rank Seq 
    # 7. Three Kind
        # 3 cards
        # Rank Match 
    # 8. Two Pair
        # 4 cards
        # Rank Match
    # 9. Pair
        # 2 cards
        # Rank Match
    # 10. High Card
        # 1 card

    # Min 5 Cards
    # 1. Royal Flush
    # 2. Straight Flush
    # 4. Full House
    # 5. Flush
    # 6. Straight

    # Min 4 Cards
    # 3. Four Kind
    # 8. Two Pair

    # Min 3 Cards
    # 7. Three Kind

    # Min 2 Cards
    # 9. Pair

    # Should return Hand consisting of MetaHand and cards 
    # which constitue the actual MetaHand
    def identify(cards)
        
        groups = cards.group_by{|card| card.rank }

        rank, freq = cards.frequency(&:rank).max_by{|k,v| v}

        if freq == 4
            return Hand.new(metahand: MetaHand::FOUR_KIND, cards: groups[rank])
        elsif freq == 3
            return Hand.new(metahand: MetaHand::THREE_KIND, cards: groups[rank])
        elsif freq == 2
            # Gets the highest valued pairs by rank, cuts off at 4 cards total (2 pair)
            pairs = groups.select{|k,v| v.size == 2}.values.flatten
                                    .sort_by{|c| c.rank.score}.reverse[0..3]
            
            return Hand.new(metahand: pairs.size == 4 ? MetaHand::TWO_PAIR : MetaHand::PAIR, cards: pairs)
        end


        straight = cards.sequences{|card| card.rank.score}
                    .select{|seq| seq.size >= 5}
                    .first

        grouped_by_suit = straight.group_by{|card| card.suit}

        straight_flush = grouped_by_suit.values.select{|grp| grp.size >= 5}.sort_by{|card| card.rank.score}



        byebug


        
        # suit_group = cards.group_by{|card| card.suit }
        
        # rank_seqs = cards.sequences{|card| card.rank.score}
        # byebug

        # meta_hands = rank_group.map{|k,v| calc_repeaters(v) }
        #                 .reject{|x| x.nil? }
            # meta_groups = metahands.group_by{|x| x}
            # .filter{|k,v| v.count == 2 || v.count == 3}

        # byebug

        # maybe_pairs = meta_groups[MetaHand::PAIR]
        # maybe_three_kinds = meta_groups[MetaHand::THREE_KIND]

        # unless maybe_pairs.nil?
        #     maybe_pairs.count
        # end

        # if maybe_pairs.nil? && maybe_three_kinds.nil?
            
        # .nil?

        # if 
        
        # elsif .nil?

        # puts meta_groups

    end

    private

    # Checks only hands that are possible with
    # two cards (only a pair in this case)
    def check_two(cards)
        rank_group = cards.group_by{|card| card.rank }
                            .filter{|k,v| v.size == 2}
    end



    def calc_repeaters(cards)
        case cards.size
        when 2
            return MetaHand::PAIR
        when 3
            return MetaHand::THREE_KIND
        when 4
            return MetaHand::FOUR_KIND
        else
            return nil
        end
    end


end