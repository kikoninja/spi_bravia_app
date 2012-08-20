SPIBraviaApp::Application.routes.draw do
  get "home/index"

  ActiveAdmin.routes(self)

  # Authnetication
  devise_for :users

  # Resources
  scope "/bivldev" do
    resources :feeds, :only => [:show]
  end

  # Matches
  match "/bivldev/sts_get_authorization/STSgetAuthorization", controller: "authorization", action: "sts_get_authorization", format: "xml"
  match "/bivldev/ssm_get_userdata/SSMgetUserData", controller: "authorization", action: "ssm_get_userdata", format: "xml"
  match "/bivldev/ssm_get_userdata", controller: "authorization", action: "ssm_get_userdata", format: "xml"
  match "/admin", controller: "admin/dashboard", action: "index"

  # Root
  root :to => 'home#index'

end
