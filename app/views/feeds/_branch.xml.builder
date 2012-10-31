xml.header do
  xml.config do
    xml.fallback_language "en"
    xml.playlist_enabled true
  end
end
xml.supported_features do
  xml.icon_formats "std"
end
xml.root_category(:id => "ROOTCAT_ID") do
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

  xml << render( :partial => 'category_navigation', :locals => { :categories => channel.categories.arrange(:order => :title)})

end
