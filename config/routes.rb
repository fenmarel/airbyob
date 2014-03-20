Airbyob::Application.routes.draw do
  root to: "static_pages#root"

  resources :users do
    resources :sites, :only => [:new, :create]
    match 'owned_sites', to: 'sites#owned', via: :get
  end

  resources :sites, :except => [:new, :create]
  resource :session, :only => [:new, :create, :destroy]
end
