require 'test_helper'

class PartTest < ActiveSupport::TestCase
  test "should require a name" do
    part = Part.new
    refute part.valid?
    assert_equal part.errors.messages, {:name=>["can't be blank"]}

    part.name = "my name"
    assert part.valid?
    assert part.save
  end
end
