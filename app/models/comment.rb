class Comment < ActiveRecord::Base
  attr_accessible :comment
  belongs_to :event
  belongs_to :user
end
