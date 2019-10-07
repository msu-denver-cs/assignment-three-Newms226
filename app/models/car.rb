class Car < ApplicationRecord
  belongs_to :make
  has_and_belongs_to_many :parts

  validates :vin, presence: true, numericality: true, uniqueness: true
  validates :model, presence: true
  validates :make_id, presence: true



  def Car.search_by_make_name(name, list=Car.all)
    make = Make.find_by_name(name)
    if make
      list.joins("INNER JOIN makes ON makes.id = #{make.id} AND cars.make_id = #{make.id}")
    else
      Car.none
    end
  end

  def Car.query(params={})
    # params = params.select { |_, value| value != ''}
    Car.select('cars.*, makes.name, parts.name')
        .joins(:make, :parts)
        .where('parts.name like ?
                AND makes.name like ?
                AND cars.vin like ?
                AND cars.model like ?',
               "%#{params[:part]}%",
               "%#{params[:make]}%",
               "%#{params[:vin]}%",
               "%#{params[:model]}%").uniq

    # if params[:make] and params[:model]
    #   by_model = Car.where('model like ?', "%#{params[:model]}%")
    #   Car.search_by_make_name(params[:make], by_model)
    # elsif params[:make]
    #   Car.search_by_make_name(params[:make])
    # elsif params[:model]
    #   Car.where('model like ?', "%#{params[:model]}%")
    # else
    #   Car.all
    # end
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
