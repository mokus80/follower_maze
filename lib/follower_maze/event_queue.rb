module FollowerMaze
  class EventQueue
    
    attr_reader :events

  	def initialize(_events)
  		@events = []
  	end

    def add_and_sort(_event_hash)
      queue = @events << _event_hash
      queue = queue.sort_by { |k, v| k[:sequence]}
    end

    
  end
end