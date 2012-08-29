SPIBraviaApp::Application.routes.draw do
  get "home/index"

  ActiveAdmin.routes(self)

  # Authentication
  # devise_for :users

  # Resources
  scope "/bivldev" do
    resources :feeds, :only => [:show]
  end
  resource :sessions, :only => [:new, :create, :destroy]
  resources :users, :only => [:new, :create]

  # Matches
  match "/bivldev/sts_get_authorization/STSgetAuthorization", controller: "authorization", action: "sts_get_authorization", format: "xml"
  match "/bivldev/ssm_get_userdata/SSMgetUserData", controller: "authorization", action: "ssm_get_userdata", format: "xml"
  match "/bivldev/ssm_get_userdata", controller: "authorization", action: "ssm_get_userdata", format: "xml"
  match "/admin", controller: "admin/dashboard", action: "index"
  match "/connect/success", controller: "home", action: "connect"

  # Root
  root :to => 'home#index'

end
