class FriendshipsController < ApplicationController
	before_action :authenticate_user!

	def index

	end

	def new
		@friendship = Friendship.new(friendship_params)
	end

	def create
	end

	def edit
	end

	def update
	end

	def destroy
    end

    private
    def friendship_params
    	params.require(:friendship).permit(:friend_id, :user_id, :user, :friend, :state)
    end

    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

end
