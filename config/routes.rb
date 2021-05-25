Rails.application.routes.draw do
  resources :games, only: :index do
    post 'play', on: :collection
  end
end
