InvideousAuth.configure do |config|

  # For development mode only, if you are behind router you should set your external address
  # config.development_server = "88.85.115.45"

  # Invideous publisher name
  config.client_name = "UNITEDGLORY"

  # Invideous publisher secret code
  config.secret_code = "J*319daS923J89v#2-HV82"
  
  # Invideous authentication URI
  # config.base_uri = "http://gateway.invideous.com:8000/invideous_masterapi/sso/" # Development
  config.base_uri = "http://api.invideous.com" # Production

end
