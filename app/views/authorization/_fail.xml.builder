xml.authorization(result: "fail") do
  xml.form(title: 'Important') do
    xml.message "Your account is not registered with FilmBOX service. To register please go to #{APP_SETTINGS[Rails.env]['registration_url']}"
  end
  #xml.asset(id: @asset_id) do
  #  xml.speed_check do
  #    xml.source(url: "http://")
  #  end
  #end
end
