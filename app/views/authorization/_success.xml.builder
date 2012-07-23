xml.authorization(result: "success", reg_in_progress: "false") do
  xml.asset(id: @asset_id) # do
    xml.speed_check do
      xml.source(url: "http://")
    end
  end
end
