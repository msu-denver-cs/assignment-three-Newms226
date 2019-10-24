require 'test_helper'

class CarTest < ActiveSupport::TestCase

  # Validation Tests

  test "should create a car with a unique VIN and all fields present" do
    car = Car.create(model: "model", vin: 400, make: makes(:audi))
    assert car.valid?
    assert car.save
  end

  test "should not allow duplicate VINs" do
    car = Car.create(model: "model", vin: cars(:my_car).vin, make: makes(:audi))
    refute car.valid?

    assert_equal car.errors.messages, {:vin=>["has already been taken"]}
  end

  test "shouldn't allow a non-number VIN" do
    car = Car.create(model: "model", vin: "not a number", make: makes(:audi))
    refute car.valid?

    assert_equal car.errors.messages, {:vin=>["is not a number"]}
  end

  test "should require a VIN" do
    car = Car.create(model: "model", make: makes(:audi))
    refute car.valid?

    assert_equal car.errors.messages, {:vin=>["can't be blank", "is not a number"]}
  end

  test "should require a model" do
    car = Car.create(make: makes(:audi), vin: 400)
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
    assert results.size == 2

    ids = results.map(&:id).sort
    exp_ids = [cars(:my_car), cars(:prius)].map(&:id).sort

    assert_equal exp_ids, ids
  end

  test 'should find cars by model name' do
    results = Car.query model: 'Q5'
    assert results.size == 2

    ids = results.map(&:id).sort
    exp_ids = [cars(:my_car), cars(:bmw_q5)].map(&:id).sort

    assert_equal exp_ids, ids
  end

  test 'should find cars by VIN' do
    results = Car.query vin: '1'
    assert results.size == 1

    ids = results.map(&:id)
    exp_ids = [cars(:my_car)].map(&:id)

    assert_equal exp_ids, ids
  end

  test 'should find cars with multiple parameters' do
    results = Car.query make: 'Audi', model: 'Q5', vin: '1'
    assert_equal results, [cars(:my_car)]

    results = Car.query make: 'Toyota', model: 'Prius', vin: '2'
    assert_equal results, [cars(:prius)]

    results = Car.query make: 'BMW', model: 'Q5', vin: '5'
    assert_equal results, [cars(:bmw_q5)]
  end

  test 'should find cars which do not have a part' do
    results = Car.query vin: '6'
    assert_equal results, [cars(:no_part)]
  end

  # Ordering tests

  test 'should order cars by make name, not id' do
    results = Car.all.order
  end

end
