Easyblog::Application.routes.draw do
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :posts do
    resources :comments
    member do
      post :mark_archived
    end
  end
end
