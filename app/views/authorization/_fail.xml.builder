xml.authorization(result: "fail") do
  xml.message "Your account is not registered with FilmBOX service. To register please go to #{APP_SETTINGS['registration_url']}"
  #xml.asset(id: @asset_id) do
  #  xml.speed_check do
  #    xml.source(url: "http://")
  #  end
  #end
end
