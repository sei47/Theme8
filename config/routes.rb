Rails.application.routes.draw do
  resources :sessions, only:[:new, :create, :destroy]
  resources :pictures do
    collection do
      post :confirm
    end
  end
  resources :users, only:[:new, :create, :show]
end
