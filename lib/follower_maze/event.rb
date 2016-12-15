module FollowerMaze
  class Event

    attr_reader :payload, :sequence, :type, :from_user, :to_user

    def initialize(_event_hash, _payload, _clients, _followers)
      array = _payload.chomp.split('|')
      @payload = _payload
      @sequence = array[0].to_s
      @type = array[1].to_s
      @from_user = array[2].to_s
      @to_user = array[3].to_s
      @event = _event_hash
      @clients = _clients
      @followers = _followers 
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
        binding.pry
        @followers.merge!(@to_user => [@from_user])
        puts "User #{@from_user} follows user #{@to_user}"
        if @clients.keys.include?(@to_user)
          @clients[@to_user].write(@payload)
        end
      when 'U'
        binding.pry
        @followers[@to_user].delete(@from_user)
        puts "User #{@from_user} unfollows user #{@to_user}"
      when 'B'
        binding.pry
        puts "Broadcasting"
        @clients.each do |client_id, client|
          client.write(@payload)
        end
      when 'S'
        puts "Status Update for followers of user #{@from_user}"
        #TO DO: add logic!
        binding.pry
        matches = @followers[@from_user].to_a & @clients.keys 
        if matches.any?
          matches.each do |match|
            @clients[match].write(@payload)
          end
          puts 'no active clients'
        end
      when 'P'
        binding.pry
        puts "Private message from user #{@from_user} to user #{@user.id}"
        @clients[@from_user].write(@payload)
      else
        ""
      end
    end

  end
end