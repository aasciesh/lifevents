class Taglist < ActiveRecord::Base
  attr_accessible :tag_id, :event_id
  belongs_to :event
  belongs_to :tag
end
