class Table

    attr_reader :players, :rounds

    def initialize(players:)
        @players = players
        @rounds = []
    end

    def run_rounds(count)
        count.times do 
            round = Round.new(table: self)
            rounds.push(round.run)
        end
        return get_win_stats
    end

    def self.run_and_print(players)
        table = Table.new(player_names: players)
        table.run_rounds(1)
        puts table.rounds.first
    end

    def self.new_and_run(player_names:, count:)
        table = Table.new(player_names: player_names)
        table.run_rounds(count)
        return table.get_win_stats
    end
    
    def get_win_stats
        rounds.map{|r| r.get_winner[1]}
        .frequency{|hand| hand.metahand}
        .map{|k,v| [k.name, v]}
        .to_h
    end

end