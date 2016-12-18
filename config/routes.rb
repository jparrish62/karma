Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' } do
    get 'users/sign_out' => 'devise/session#destroy'
  end
  get '/oauth2callback' => 'calendar_appointments#callback'
  get '/calendar_appointments' => 'calendar_appointments#calendars'

  resources :users do
    collection do
      get 'search'
    end
  end

  root 'homes#index'

  get '/prices' => 'homes#price', as: 'price'

  resources :homes

  resources :stylists do
    resources :appointments
    resources :works do
     resources :comments
    end
  end

  resources :comments do
    resources :comments
  end
end
