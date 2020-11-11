class IdentificationService

    def identify(cards)
        
        rank_group = cards.group_by{|card| card.rank }
        suit_group = cards.group_by{|card| card.suit }
        

        sequence = cards.sort_b

        meta_hands = rank_group.map{|k,v| calc_repeaters(v) }
                        .reject{|x| x.nil? }
        
        

        byebug

        puts meta_hands

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