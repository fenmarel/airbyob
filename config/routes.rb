Airbyob::Application.routes.draw do
  root to: "session#new"
  resources :users
  resource :session, :only => [:new, :create, :destroy]
end
