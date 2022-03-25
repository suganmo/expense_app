Rails.application.routes.draw do
  get 'users/confirm_expense'

  get 'expenses/notice_expense'

  #devise_for :customers
  #devise_for :admins
  get 'users/show'
  get 'homes/index'
  get 'expense/new'
  get 'expense/notice_expense'
  #root 'homes#index'
  
  devise_scope :user do
    root :to => "devise/sessions#new"
    end
    #resources :user,only: [:show,:index,:edit,:update]
  resource :users, only: [:show, :notice_expense,:confirm_expense]
  resource :expenses, only: [:new, :notice_expense,:confirm_expense]  
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  
  resources :expenses do
      collection {post :import}
      member do
      get 'expense_request'
      get 'notice_expense'
      get 'approval_expense'
      get 'confirm_expense'
      get 'expense_create'
      delete 'expense_destroy'
    end
  end
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
