require 'test_helper'

class MakeTest < ActiveSupport::TestCase
  test "shouldn't be valid without a name" do
    make = Make.create(country: "my country")
    refute make.valid?


    assert_equal make.errors.messages, {:name=>["can't be blank"]}
  end

  test "shouldn't be valid without a country" do
    make = Make.create(name: "my name")
    refute make.valid?


    assert_equal make.errors.messages, {:country=>["can't be blank"]}
  end

  test "should be valid with a name and a country" do
    make = Make.create(name: "my name", country: "my country")
    assert make.valid?
    assert make.save
  end
end
