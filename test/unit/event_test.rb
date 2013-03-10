require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "should not save event without title" do
  	event= events(:one)
  	event.title = ""
  	assert event.invalid?
    assert !event.save
  end
end
