class Friendship < ActiveRecord::Base
  attr_accessible :friend_id, :user_id, :status

  belongs_to :user
  belongs_to :friend, class_name: "User"

  # 0 denotes friend request pending to be approved, 1 denotes approved
  validates :status, :inclusion=> { :in => [1,0] }
end