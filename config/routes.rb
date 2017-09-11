Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :users do
    get 'sign_in', to: 'users/sessions#new'
  end

  root 'pages#homepage'

  resources :trips do
    resources :topics, only:[:new, :create]
    get 'leave', on: :member
    get 'create_auto', to: "topics#create_auto"

    resources :invites, only:[:new, :create] do
      get 'confirm', on: :member
      get 'decline', on: :member
    end
  end

  resources :surveys, only:[:show, :destroy] do
    member do
      get 'vote'
      get 'set_deadline'
      post 'send_deadline'
    end
  end

  resources :topics, only:[:edit, :update, :destroy] do
    member do
      get 'confirm'
      post 'close'
      get 'get_suggestion'
    end
    resources :suggestions, only:[:new, :create, :destroy, :edit, :update]
  end

  get 'vote', to: "suggestions#vote"

end
