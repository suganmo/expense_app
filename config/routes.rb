Rails.application.routes.draw do
  get 'users/show'
  get 'homes/index'
  get 'expense/new'
  #root 'homes#index'
  
  devise_scope :user do
    root :to => "devise/sessions#new"
    end
    #resources :user,only: [:show,:index,:edit,:update]
  resource :users, only: [:show]
  resources :expenses do
    collection {post :import}
    member do
    get 'expense_request'
    get 'expense_create'
    delete 'expense_destroy'
  end
end

  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
