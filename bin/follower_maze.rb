require 'socket'
require 'thread'
require 'pry'
require './lib/follower_maze/event_queue'
require './lib/follower_maze/user'
require './lib/follower_maze/event'
require './lib/follower_maze/server'

server = FollowerMaze::Server.new(event_server = TCPServer.open(9090), client_server = TCPServer.open(9099)
)
server.run



