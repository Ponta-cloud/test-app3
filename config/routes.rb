Rails.application.routes.draw do
  root 'users#index'
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "users/create" => "users#create"
  get "signup" => "users#new"
end
