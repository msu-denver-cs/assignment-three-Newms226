module CarsHelper

  def get_order_url(order_by)
    # binding.pry
    if request.path.include? 'cars/search' || request.headers['HTTP_REFERER'].include?('cars/search')
      puts 'SEARCH FOUND'
      search_cars_url pick_apart_search(order_by)
    else
      puts 'NO SEARCH FOUND'
      cars_url(order: order_by)
    end
  end

  private
    def pick_apart_search(order_by)
      {
          order: order_by,
          make: params[:make] || '',
          model: params[:model] || '',
          vin: params[:vin] || '',
          part: params[:part] || '',
          page: params[:page]
      }
    end
end
