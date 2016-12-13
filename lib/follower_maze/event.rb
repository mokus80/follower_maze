module FollowerMaze
  class Event

    attr_reader :payload, :sequence, :type, :from_user, :to_user

    def initialize(_payload, _clients)
      array = _payload.chomp.split('|')
      @payload = _payload
      @sequence = array[0]
      @type = array[1]
      @from_user = array[2]
      @to_user = array[3]
      #@event = _event_hash
      @clients = _clients
      @user = User.new(@event[:to_user]) if !@to_user.nil?
    end

    def self.parsed_event(_payload)
      array = _payload.chomp.split('|')
      { sequence: array[0], type: array[1], from_user: array[2], to_user: array[3] }
    end

    def to_hash
      { sequence: self.sequence, type: self.type, from_user: self.from_user, to_user: self.to_user }
    end

# * **Follow**: Only the `To User Id` should be notified
# * **Unfollow**: No clients should be notified
# * **Broadcast**: All connected *user clients* should be notified
# * **Private Message**: Only the `To User Id` should be notified
# * **Status Update**: All current followers of the `From User ID` should be notified

    def process
      binding.pry
      case @type
      when 'F'
        if @user
          @user.add_follower(@from_user)
          puts "User #{@from_user} follows user #{@user.id}"
          binding.pry
          @clients[@user_id.to_s].write('hi')
        end
      when 'U'
        if @user
          puts "User #{@from_user} unfollows user #{@user.id}"
          binding.pry
          @user.remove_follower(@from_user)
        end
      when 'B'
        puts "Broadcasting"
        binding.pry
        @clients.each do |client_id, client|
          client.write("hi")
        end
      when 'S'
        if @user
          puts "Status Update for followers of user #{@user.id}"
          binding.pry
          @user.followers.each do |f|
            @client["#{f}"].write("hi")
          end
        end
      when 'P'
        if @user
          puts "Private message from user #{@from_user} to user #{@user.id}"
          binding.pry
          @clients[@user_id.to_s].write('hi')
        end
      else
        ""
      end
    end

  end
end