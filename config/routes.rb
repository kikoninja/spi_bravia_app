SPIBraviaApp::Application.routes.draw do

  ActiveAdmin.routes(self)

  scope ':locale', locale: /#{I18n.available_locales.join("|")}/ do

    get "home/index"

    # Root
    root :to => 'home#index'
    
  end

  # Resources
  scope "/bivldev" do
    resources :feeds, :only => [:show]
  end

  resource :sessions, :only => [:new, :create, :destroy]
  resources :users, :only => [:new, :create]

  namespace :admin do
    resources :sessions, :only => [:new, :create, :destroy]
  end

  # Matches
  match "/bivldev/sts_get_authorization/STSgetAuthorization", controller: "authorization", action: "sts_get_authorization", format: "xml"
  match "/bivldev/sts_get_authorization", controller: "authorization", action: "sts_get_authorization", format: "xml"
  match "/bivldev/ssm_get_userdata/SSMgetUserData", controller: "authorization", action: "ssm_get_userdata", format: "xml"
  match "/bivldev/ssm_get_userdata", controller: "authorization", action: "ssm_get_userdata", format: "xml"
  match "/bivldev/disconnect", controller: "authorization", action: "disconnect"
  match "/admin", controller: "admin/dashboard", action: "index"
  match "/connect/success", controller: "home", action: "connect"
  match "/admin/logout", controller: "admin/sessions", action: "destroy"

  match '*path', to: redirect("/#{I18n.default_locale}/%{path}")
  match '', to: redirect("/#{I18n.default_locale}")

end
