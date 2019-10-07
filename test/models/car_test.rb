require 'test_helper'

class CarTest < ActiveSupport::TestCase

  # Validation Tests

  test "should create a car with a unique VIN and all fields present" do
    car = Car.create(model: "model", vin: 400, make: makes(:one))
    assert car.valid?
    assert car.save
  end

  test "should not allow duplicate VINs" do
    car = Car.create(model: "model", vin: cars(:one).vin, make: makes(:one))
    refute car.valid?

    assert_equal car.errors.messages, {:vin=>["has already been taken"]}
  end

  test "shouldn't allow a non-number VIN" do
    car = Car.create(model: "model", vin: "not a number", make: makes(:one))
    refute car.valid?

    assert_equal car.errors.messages, {:vin=>["is not a number"]}
  end

  test "should require a VIN" do
    car = Car.create(model: "model", make: makes(:one))
    refute car.valid?

    assert_equal car.errors.messages, {:vin=>["can't be blank", "is not a number"]}
  end

  test "should require a model" do
    car = Car.create(make: makes(:one), vin: 400)
    refute car.valid?

    assert_equal car.errors.messages, {:model=>["can't be blank"]}
  end

  test "should require a make" do
    car = Car.create(model: "model", vin: 400)
    refute car.valid?

    assert_equal car.errors.messages, {:make=>["must exist"], :make_id=>["can't be blank"]}
  end

  # Search Tests

  test 'Should find cars by make name' do
    results = Car.query make: 'Audi'
    assert results.size == 2

    ids = results.map(&:id).sort
    exp_ids = [cars(:my_car), cars(:q7_rental)].map(&:id).sort

    assert_equal exp_ids, ids
  end

  test 'should find cars by part name' do
    results = Car.query part: 'wheel'
    asser
  end

end
