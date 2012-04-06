SPIBraviaApp::Application.routes.draw do
  ActiveAdmin.routes(self)

  # Authnetication
  devise_for :users

  # Resources
  scope "/bivldev" do
    resources :feeds, :only => [:show]
  end

  # Root
  root :to => 'admin/dashboard#index'

end
