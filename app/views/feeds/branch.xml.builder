xml.instruct!
xml.trebuchet(:version => "2.0") do
  xml.mehta_data_version 1
  xml.header do
    xml.config do
      xml.fallback_language "en"
      xml.playlist_enabled true
    end
  end
  xml.supported_features do
    xml.icon_formats "std"
  end
  xml.root_category(:id => "ROOTCAT_ID", :style => "tile")
end

