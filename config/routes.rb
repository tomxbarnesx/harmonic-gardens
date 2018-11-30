Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "pages#landing"

  resources :shifts
  get 'shifts/day_log/:date', to: 'shifts#day_log'

  resources :clients
  resources :users
  resources :materials
  
  resources :invoices do
    resources :invoice_dates, shallow: true do 
      resources :shift_dates
      resources :material_dates
    end
  end

  # get '/invoices/:id/pdf', to: 'invoices#set_pdf', as: 'invoice_set_pdf'

  
end
