NinetyNineCatsDay1::Application.routes.draw do
  resources :cats, except: :destroy
  resources :cat_rental_requests, only: [:create, :new] do
    post "approve", on: :member
    post "deny", on: :member
  end

  root to: redirect("/cats")

  post "user", to: "users#create"
  resources :users, only: [:new]
  resource :session, only: [:new, :create, :destroy]
end
