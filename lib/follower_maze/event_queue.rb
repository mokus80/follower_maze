module FollowerMaze
  class EventQueue
    
    attr_reader :events

  	def initialize(_events)
  		@events = []
  	end

    def self.parsed_event(_payload)
      array = _payload.chomp.split('|')
      { sequence: array[0], type: array[1], from_user: array[2], to_user: array[3] }
    end

    def add_and_sort(_payload)
      #binding.pry
      queue = @events << FollowerMaze::EventQueue.parsed_event(_payload)
      queue = queue.sort_by { |k, v| k[:sequence]}
    end

    # def process(_user, parsed_event)
    #   case parsed_event[:type]
    #   when F and _parsed_event[:to_user].present? 
    #     _
    #   when U then 
    #   when B then
    #   when S then
    #   when P then
    # end
  end
end