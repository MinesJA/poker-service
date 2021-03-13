class RoundActor < Concurrent::Actor::RestartingContext

    def initialize()
        @round = nil
    end

    # override #on_message to define actor's behaviour on message received
    def on_message(message)
        case message.action
        when :run
            @round = run_round(message.data)
        when :value
            @round
        else
            pass
        end
    end

    
    def on_event(event)
        if event == :reset
            # TODO: what to do if there's an issue?
        end
    end
end 