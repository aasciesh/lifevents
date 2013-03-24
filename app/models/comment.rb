class Comment < ActiveRecord::Base
  attr_accessible :comment
  belongs_to :event, include: :user
  belongs_to :user
end
