SPIBraviaApp::Application.routes.draw do
  ActiveAdmin.routes(self)

  # Authnetication
  devise_for :users

  # Resources
  scope "/bivldev" do
    resources :feeds, :only => [:show]
  end

  # Matches
  match "/bivldev/sts_get_authorization/STSgetAuthorization", controller: "authorization", action: "sts_get_authorization"

  # Root
  root :to => 'admin/dashboard#index'

end
