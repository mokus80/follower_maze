require 'socket'
require 'thread'
require 'pry'
require './lib/follower_maze/event_queue'
require './lib/follower_maze/user'


event_queue = FollowerMaze::EventQueue.new([])
queue = event_queue.events

event_server = TCPServer.open(9090)
event_socket = event_server.accept

client_server = TCPServer.open(9099)

puts "event source connected"
  events = Thread.start(event_socket) do |event|
    while payload = event.gets do
      #binding.pry
      queue = event_queue.add_and_sort(payload)
      puts "|#{queue}|"
  end
end

loop do
  client_socket = client_server.accept
  clients = Thread.start(client_socket) do |client|
    id = client.gets
    puts id
    #client.close
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