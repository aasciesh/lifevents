class Taglist < ActiveRecord::Base
  attr_accessible :tag_id, :user_id
  belongs_to :event
  belongs_to :tag
end
