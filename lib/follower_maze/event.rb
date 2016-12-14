module FollowerMaze
  class Event

    attr_reader :payload, :sequence, :type, :from_user, :to_user

    def initialize(_event_hash, _payload, _clients)
      array = _payload.chomp.split('|')
      @payload = _payload
      @sequence = array[0]
      @type = array[1]
      @from_user = array[2]
      @to_user = array[3]
      @event = _event_hash
      @clients = _clients
      #binding.pry
      #@user = User.new(@to_user) if !@to_user.nil?
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
      case @type
      when 'F'
        @user = User.new(@to_user) if !@to_user.nil?
        if @user
          binding.pry
          @user.add_follower(@from_user)
          puts "User #{@from_user} follows user #{@user.id}"
          binding.pry
          @clients[@user.id.to_s].write(@payload)
        else
          puts "no user"
        end
      when 'U'
        @user = User.new(@to_user) if !@to_user.nil?
        if @user
          #binding.pry
          puts "User #{@from_user} unfollows user #{@user.id}"
          #binding.pry
          @user.remove_follower(@from_user)
        else
          puts "no user"
        end
      when 'B'
        puts "Broadcasting"
        #binding.pry
        @clients.each do |client_id, client|
          client.write(@payload)
        end
      when 'S'
        @user = User.new(@from_user) if !@from_user.nil?
        if @user
          #binding.pry
          if @user.followers.any?
            puts "Status Update for followers of user #{@user.id}"
            @user.followers.each do |f|
              @client["#{f}"].write(@payload)
            end
          else
            ""
          end
        else
          ""
        end
      when 'P'
        #binding.pry
        puts "Private message from user #{@from_user} to user #{@user.id}"
        #binding.pry
        @clients[@user.id.to_s].write(@payload)
      else
        ""
      end
    end

  end
end