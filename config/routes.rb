Rails.application.routes.draw do
  root 'service_users#index'
  get "login" => "service_users#login_form"
  post "login" => "service_users#login"
  post "users/create" => "service_users#create"
  get "signup" => "service_users#new"
end
