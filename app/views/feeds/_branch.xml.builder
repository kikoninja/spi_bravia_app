xml.header do
  xml.config do
    xml.fallback_language "en"
    xml.playlist_enabled true
  end
end
xml.supported_features do
  xml.icon_formats "std"
end
xml.root_category(:id => "ROOTCAT_ID", :style => "tile") do
  xml.default_icons do
    # TODO: PD: get this from the channel
    xml.icon_std "http://w4.invideous.com/demo/root_category.png"
  end
  xml.languages do
    xml.language(:id => "en") do
      xml.title channel.title
      xml.description channel.description
    end
  end

  channel.categories.each do |category|
    xml.category(:id => category.id, :style => "tile", :order => category.order) do
      xml.default_icons do
        xml.icon_std "http://bivlspidev.invideous.com#{category.icon.url(:small)}"
      end
      xml.languages do
        xml.language(:id => "en") do
          xml.title category.title
          xml.description category.description
        end
      end
    end
  end
end
