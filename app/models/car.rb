class Car < ApplicationRecord
  belongs_to :make
  has_and_belongs_to_many :parts

  validates :vin, presence: true, numericality: true, uniqueness: true
  validates :model, presence: true
  validates :make_id, presence: true
  # validates :part_ids, presence: true

  def Car.no_part_query(params={})
    Car.select('cars.*, makes.name')
        .joins(:make)
        .where('makes.name like ?
                AND cars.vin like ?
                AND cars.model like ?',
               "%#{params[:make]}%",
               "%#{params[:vin]}%",
               "%#{params[:model]}%").uniq
  end

  def Car.with_part_query(params={})
    Car.select('cars.*, makes.name, parts.name')
        .joins(:make, :parts)
        .where('parts.name like ?
                AND makes.name like ?
                AND cars.vin like ?
                AND cars.model like ?',
               "%#{params[:part]}%",
               "%#{params[:make]}%",
               "%#{params[:vin]}%",
               "%#{params[:model]}%")
        .order('makes.name').uniq
  end

  def Car.query(params={})
    if not params[:part] || params[:part] == ''
      Car.no_part_query(params)
    else
      Car.with_part_query(params)
    end
  end

  # def Car.query2(params)
  #   .joins("INNER JOIN makes ON makes.id = #{make.id} AND cars.make_id = #{make.id}")
  # end

    # model = params[:model] == '' ? nil : "%#{params[:model]}%"
    # # should prove to be equal statements, as nil != ''
    # make = params[:make] == '' ? nil : "%#{params[:make]}%"
    #
    # print "MAKE: #{make}"
    # print "MODEL: #{model}"
    #
    # # by_make = Car.find_by()
    #
    # cars = []
    # if make
    #
    #   Car.joins('INNER JOIN makes ON makes.id = 1 AND cars.make_id = 1').where('model = ?', 'Q5')
    # end
    # cars = []
    #
    # if params[:make] && params[:make] != ''
    #   make_id = Make.find_by_name(params[:make])
    #   print "FOUND MAKE ID #{make_id.id}\n"


    # car = []
    # if make_id and params[:model] && params[:model] != ''
    #   print 'route a'
    #   car.append Car.find_by_make_id_and_model(make_id.id, params[:model])
    # elsif params[:model] && params[:model] != ''
    #   print 'route b'
    #   car.append Car.find_by_model(params[:model])
    # else
    #   print 'no vars'
    #   car = Car.all
    # end

    # print "RETURNING CARS: #{car}"
    # car
    # ''
  # end
end
