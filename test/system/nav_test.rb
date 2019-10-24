require "application_system_test_case"

class MakesTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    login_as(users(:one), :scope => :user)
  end

  test 'active link should change based on active link' do
    visit root_url
    assert_selector 'li.active', text: "Cars"

    visit cars_url
    assert_selector 'li.active', text: "Cars"

    visit makes_url
    assert_selector 'li.active', text: "Makes"

    visit parts_url
    assert_selector 'li.active', text: "Parts"
  end

end