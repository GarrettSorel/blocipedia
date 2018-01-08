Rails.application.routes.draw do
  devise_for :users
  
  resources :wikis do
    resources :collaborators, only: [:new, :create, :destroy]
  end  
  
  resources :charges, only: [:new, :create, :destroy]

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
