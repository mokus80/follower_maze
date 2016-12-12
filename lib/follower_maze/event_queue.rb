module FollowerMaze
  class EventQueue
    
    attr_reader :events

  	def initialize
  		@events = []
  	end

    def add_and_sort(_payload) #use _event
      # use @events << _event_hash
      queue = @events << FollowerMaze::Event.parsed_event(_payload) 
      queue = queue.sort_by { |k, v| k[:sequence]}
    end

    
  end
end