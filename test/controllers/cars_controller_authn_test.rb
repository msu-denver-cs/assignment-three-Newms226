require 'test_helper'

class CarsControllerAuthnTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @car = cars(:my_car)
    assert_signed_out
  end

  test "should load the index when the user isn't signed in" do
    get cars_url
    assert_response :success
  end

  test "should refuse editing when the user isn't signed in" do
    get edit_car_url(@car)
    assert_redirected_to new_user_session_url

    assert_no_difference('Car.count') do
      post cars_url, params: { car: { make_id: @car.make_id, model: @car.model, vin: 10 } }
      assert_redirected_to new_user_session_url
    end
  end

  test "shouldn't destroy car when not signed in" do
    assert_no_difference('Car.count') do
      delete car_url(@car)
      assert_redirected_to new_user_session_url
    end
  end

  test "shouldn't create car when not signed in" do
    assert_no_difference('Car.count') do
      post cars_url, params: { car: { make_id: @car.make_id, model: @car.model, vin: 10 } }
    end

    assert_redirected_to new_user_session_url
  end
end