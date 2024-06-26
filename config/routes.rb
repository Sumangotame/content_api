Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'auth/signin'=> 'auth#create'
      post 'users/signup'=>'users#create'
      resources :contents, only:[:create,:update,:destroy,:index]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
