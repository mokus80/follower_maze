require 'socket'
require 'thread'
require 'pry'
require './lib/follower_maze/event_queue'
require './lib/follower_maze/user'


event = FollowerMaze::Event.new("3|S|3\n") #just testing if class responds
event_queue = FollowerMaze::EventQueue.new([])

event_server = TCPServer.open(9090)
event_socket = event_server.accept

client_server = TCPServer.open(9099)

puts "event source connected"
  events = Thread.start(event_socket) do |event|
    while payload = event.gets do
      puts payload
      event = FollowerMaze::Event.new(payload)
      queue = event_queue.add_and_sort(event.to_hash)
      puts "|#{queue}|"
  end
end

loop do
  client_socket = client_server.accept
  clients = Thread.start(client_socket) do |client|
    id = client.gets
    puts "#{id} registered"
    user = FollowerMaze::User.new(id)
    puts "#{user.id} created"
  end
end

# process = Thread.new do
#   puts "hi"
#   loop do
#     puts "get here"
#     value = queue.pop
#     puts value
#   end
# end