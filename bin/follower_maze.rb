require 'socket'
require 'thread'
require 'pry'
require 'logger'
require './lib/follower_maze/event_queue'
require './lib/follower_maze/user'
require './lib/follower_maze/event'
require './lib/follower_maze/connection'


connection = FollowerMaze::Connection.new(event_server = TCPServer.open(9090), client_server = TCPServer.open(9099)
)
connection.run