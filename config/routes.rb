Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations] 
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "pages#landing"

  resources :shifts
  get 'shifts/day_log/:date', to: 'shifts#day_log'

  get 'clients/archived', to: 'clients#archived', as: :archived_clients
  put 'clients/archive/:id', to: 'clients#archive', as: :archive_client
  resources :clients

  get 'users/archived', to: 'users#archived', as: :archived_users
  put 'users/archive/:id', to: 'users#archive', as: :archive_user
  resources :users

  resources :materials
  resources :material_dates
  
  get 'invoices/archive', to: 'invoices#archive'
  resources :invoices do
    resources :invoice_dates, shallow: true do 
      resources :shift_dates
      # resources :material_dates
    end
  end

  # get 'completed', to: 'tasks#completed', as: :completed_tasks
  # get '/invoices/:id/pdf', to: 'invoices#set_pdf', as: 'invoice_set_pdf'

  
end
