class Table

    attr_reader :players, :rounds

    def initialize(player_names:)
        @players = player_names.map{|name| Player.new(name: name)}
        @rounds = []
    end

    def run_rounds(count)
        count.times do 
            round = Round.new(table: self)
            rounds.push(round.run)
        end
    end

    def self.run_and_print(players)
        table = Table.new(player_names: players)
        table.run_rounds(1)
        puts table.rounds.first
    end

end