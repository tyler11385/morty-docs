Rails.application.routes.draw do
  namespace :api do
    post 'signup', to: 'auth#signup'
    post 'login', to: 'auth#login'
    get 'me', to: 'auth#me'
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: proc { [200, {}, ['{"status":"ok"}']] }
end
