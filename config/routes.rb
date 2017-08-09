Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#index'
  resources :notes
  get 'users/:id/follow', to: 'followers#follow', as: :follow
  get 'users/:id/unfollow' => 'followers#unfollow', as: :unfollow 
  get '/other_users' => 'users#other_users' 
  get 'notes/:id/upvote', to: 'votes#upvote', as: :upvote
  get 'notes/:id/downvote' => 'votes#downvote', as: :downvote 

end
