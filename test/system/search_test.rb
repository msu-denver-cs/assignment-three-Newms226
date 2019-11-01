require "application_system_test_case"

class SearchTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  # setup do
  #   login_as(users(:one), :scope => :user)
  # end

  test 'should allow sorting after searching' do
    visit cars_url
    fill_in 'model', with: 'Q5'
    click_on 'Search'

    assert_selector 'td', text: 'BMW', match: :first
    assert_selector 'td', text: 'Audi', match: :first
    assert_no_selector 'td', text: 'Ford'

    click_on 'Model'
    assert_selector 'td', text: 'BMW', match: :first
    assert_selector 'td', text: 'Audi', match: :first
    assert_no_selector 'td', text: 'Ford'

  end
end