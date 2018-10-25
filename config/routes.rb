Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "pages#landing"

  resources :shifts
  resources :clients
  resources :users
  resources :materials
  
  resources :invoices do
    resources :invoice_dates, shallow: true do 
      resources :shift_dates
      resources :materials_dates
    end
  end
  
end
