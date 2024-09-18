Rails.application.routes.draw do

  get 'google_login_api/callback'
  get 'password_resets/new'
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
  root "static_pages#top"
 
  resource :session, only: [:new, :create, :destroy]
  get '/auth/:provider/callback', to: 'sessions#google_oauth2'
  get '/auth/failure', to: redirect('/')
  resources :static_pages, only: %i[new create show edit update destroy] do
end
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :boards do
    resources :comments, only: [:create, :update, :destroy]
  end
  resources :password_resets, only: %i[new create edit update]
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  delete 'logout', to: 'sessions#destroy'
  post '/google_login_api/callback', to: 'google_login_api#callback'
end
