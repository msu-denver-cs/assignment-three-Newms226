Rails.application.routes.draw do
  resources :parts do
    get :autocomplete_part_name, on: :collection

    collection do
      get 'search'
    end
  end

  resources :makes

  resources :cars do
    get :autocomplete_car_model, on: :collection

    collection do
      get 'search'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
