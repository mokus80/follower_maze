module FollowerMaze
  class Connection

    def initialize(_event_server, _client_server)
      @event_server = _event_server
      @client_server = _client_server
      @event_queue = FollowerMaze::EventQueue.new()
      @clients = {}
    end

    def run
      puts "event source connected"
      event_socket = @event_server.accept
      events = Thread.start(event_socket) do |event|
        while payload = event.gets do
          # TO DO: use event
          @queue = @event_queue.add_and_sort(payload)
          puts "|#{@queue}|"
          #puts " ************** #{@clients}"
          @queue.each do |event_hash|
            puts event_hash
            #binding.pry
            
            #ONLY ADDED THIS FOR DEBUGGING PURPOSES
            if event_hash[:to_user].nil? && event_hash[:type] == "S"
              next
              #binding.pry
            else
              event = FollowerMaze::Event.new(event_hash, payload, @clients)
            #else
              #binding.pry
            
            #end
            event.process
            
            end
          end
        end
      end

      loop do
        client_socket = @client_server.accept
        clients = Thread.start(client_socket) do |client|
          id = client.gets
          puts "#{id} registered"
          @clients.merge!(id.chomp.to_s => client)
          #puts @clients
          #puts "<<<<<<<<<<<<<<< #{@queue}"
          #user = FollowerMaze::User.new(id)
          #puts "#{user.id} created"
        end
      end
    end
  end
end

