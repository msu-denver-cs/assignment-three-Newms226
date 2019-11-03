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

  test 'should be sorted by name by default' do
    actual = Make.index
    assert_equal [makes(:audi), makes(:bmw), makes(:ford), makes(:ram), makes(:toyota), makes(:zeo)], actual

    actual = Make.query name: 'o'
    assert_equal [makes(:ford), makes(:toyota), makes(:zeo)], actual
  end

  test 'should sort by country name' do
    actual = Make.index order: 'country'
    assert_equal [makes(:zeo), makes(:audi), makes(:bmw), makes(:ford), makes(:ram), makes(:toyota)], actual

    actual = Make.query name: 'o'
    assert_equal [makes(:zeo), makes(:ford), makes(:toyota)], actual
  end
end
