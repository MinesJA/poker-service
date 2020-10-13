describe TableService, '.new' do
    it 'Should run through a round' do
        tb = TableService.new(5)

        tb.run_round()

        byebug
        puts "results"


    end
end