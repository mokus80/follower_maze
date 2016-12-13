module FollowerMaze
  class User

    attr_reader :id, :followers

    def initialize(_id)
      @id = _id
      @followers = []
    end

    def add_follower(_client_id)
  	  @followers << _user_id
    end

    def remove_follower(_clients_id)
  	  @followers.delete(_user_id)
    end
  end
end