class UserNotifier < ActionMailer::Base
  default from: "from@example.com"

  def friend_requested(friendship_id)
    get_friends

    mail to: @friend.email,
         subject: "#{@user.email} wants to be friends"
  end

  def friend_request_accepted(friendship_id)
  	get_friends
    mail to: @user.email,
         subject: "#{@friend.email} has accepted your friend request."
  end

  private
    def get_friends
		friendship = Friendship.find(friendship_id)

		@user = friendship.user
		@friend = friendship.friend
    end

end
