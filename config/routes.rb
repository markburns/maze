Rails.application.routes.draw do
  resources :mazes, only: [:new, :create, :show]
end
