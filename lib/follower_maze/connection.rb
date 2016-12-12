module FollowerMaze
  class Connection

    def initialize(_event_server, _client_server)
      @event_server = _event_server
      @client_server = _client_server
      @event_queue = FollowerMaze::EventQueue.new()
    end

    def run
      puts "event source connected"
      event_socket = @event_server.accept
      events = Thread.start(event_socket) do |event|
        while payload = event.gets do
          # TO DO: use event
          #event = FollowerMaze::Event.new(payload)
          queue = @event_queue.add_and_sort(payload)
          puts "|#{queue}|"
        end
      end

      loop do
        client_socket = @client_server.accept
        clients = Thread.start(client_socket) do |client|
          id = client.gets
          puts "#{id} registered"
          user = FollowerMaze::User.new(id)
          puts "#{user.id} created"
        end
      end
    end
  end
end

