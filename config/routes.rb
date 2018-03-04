Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  resources :articles do
    post :add_like, on: :member

    resources :comments, only: [:create, :destroy]
  end

  # get 'articles', to: 'articles#index'
  # get 'articles/new', to: 'articles#new', as: 'new_article'
  # post 'articles', to: 'articles#create'
  # get 'articles/:id', to: 'articles#show', as: 'article'
  # delete 'articles/:id', to: 'articles#destroy'
  # get 'articles/:id/edit', to: 'articles#edit', as: 'edit_article'
  # patch 'articles/:id', to: 'articles#update'
end
