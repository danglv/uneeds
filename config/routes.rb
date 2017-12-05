Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq" # monitoring console

  root "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope "(:locale)" do
    devise_for :users
    resources :transfers do
      collection do
        post :fee
      end
    end
  end
  post "locales/change", to: "locales#change"
  # scope module: :admin, as: :admin do
  #   resources :exchanges
  # end
  namespace :admin do
    resources :exchanges
    resources :transfers
  end
end
