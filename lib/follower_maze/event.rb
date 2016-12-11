module FollowerMaze
  class Event

    #attr_reader :payload, :sequence, :type, :from_user, :to_user

    def initialize(_payload)
      array = _payload.chomp.split('|')
      @sequence = array[0]
      @type = array[1]
      @from_user = array[2]
      @to_user = array[3]
    end

  	# def process(_user, _event)
   #    case _event
   #    when F and and _event.to_user.present? 
   #      _
   #    when U then 
   #    when B then
   #    when S then
   #    when P then
   #  end
  end
end