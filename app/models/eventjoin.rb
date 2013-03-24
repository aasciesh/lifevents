class Eventjoin < ActiveRecord::Base
  attr_accessible :joinedevent_id, :eventjoiner_id 

   belongs_to :eventjoiner, class_name: "User"
   belongs_to :joinedevent, class_name: "Event"

   validates_uniqueness_of :eventjoiner_id, :scope => [:joinedevent_id]

end
