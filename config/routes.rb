Rails.application.routes.draw do
  root "static_pages#top"
 
  resource :session, only: [:new, :create, :destroy]
  resources :static_pages, only: %i[new create show edit update destroy] do
end
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :boards do
    resources :comments, only: [:create, :update, :destroy]
  end
  delete 'logout', to: 'sessions#destroy'
end
