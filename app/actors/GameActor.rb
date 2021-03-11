

class GameActor < Concurrent::Actor::RestartingContext
  def initialize(init)
    @counter = init
  end

  #   def play_rounds(round_count:, deck:, holes:, community:)
  # deck:, holes:, community:

  # override #on_message to define actor's behaviour on message received
  def on_message(message)
    case message.action
    when :run
      @counter = @counter + message.value
    when :subtract
      @counter = @counter - message.value
    when :value
      @counter
    else
      pass
    end
  end

  # set counter to zero when there is an error
  def on_event(event)
    if event == :reset
      @counter = 0 # ignore initial value
    end
  end
end 

an_actor = AnActor.spawn name: 'an_actor', args: 10 
an_actor << Message.new(:add, 1) << Message.new(:subtract, 2) 
an_actor.ask!(Message.new(:value, nil))            # => 9
an_actor << :boo << Message.new(:add, 1) 
an_actor.ask!(Message.new(:value, nil))            # => 1
an_actor << :terminate!

Message = Struct.new :action, :value 
class GameActor < Concurrent::Actor::RestartingContext
    def initialize(init)
      @Round = init
    end

    def on_message(msg)
      # Assuming only one kind of message right now
      gs = GameService.new()
      gs.run_round(msg.value.deck, msg.value.holes, msg.value.community)

      puts "#{path} second:#{(Time.now.to_f*100).floor} message:#{io_job}"
    end
    
    def on_event(event)
      if event == :reset
        # Todo: handle errors
      end
    end
  
    def default_executor
      Concurrent.global_io_executor
    end
end
  



#   http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/Actor/Utils/Pool.html
  pool = Concurrent::Actor::Utils::Pool.spawn('pool', 2) do |index|
    GameActor.spawn(name: "worker-#{index}")
  end

  pool



  pool << 1 << 2 << 3 << 4 << 5 << 6
    # => #

# prints two lines each second
# /pool/worker-0 second:1414677666 message:1
# /pool/worker-1 second:1414677666 message:2
# /pool/worker-0 second:1414677667 message:3
# /pool/worker-1 second:1414677667 message:4
# /pool/worker-0 second:1414677668 message:5
# /pool/worker-1 second:1414677668 message:6


# What I think I want to do is send the same message of run_round with whatever vars over and over
# x times