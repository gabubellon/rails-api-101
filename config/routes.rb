Rails.application.routes.draw do
  resources :books do
    resources :authors
  end
  resources :authors do
    resources :books
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end