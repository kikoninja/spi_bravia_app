xml.header do
  xml.config do
    xml.fallback_language "en"
    xml.playlist_enabled true
  end
end
xml.supported_features do
  xml.icon_formats "std"
end
xml.regions do
  xml.region(:id => publisher.region_id)
  xml.country(:cc => publisher.country_code)
end
#   xml.region(:id => 2) do
#     xml.country("CZ", :fallback_language => "cs")
#   end
#   xml.region(:id => 3) do
#     xml.country("HU", :fallback_language => "hu")
#   end
#   xml.region(:id => 4) do
#     xml.country("PL", :fallback_language => "pl")
#   end
#   xml.region(:id => 5) do
#     xml.country("RO", :fallback_language => "ro")
#   end
#   xml.region(:id => 6) do
#     xml.country("TR", :fallback_language => "tr")
#   end
# end

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
    # xml.language(:id => "cs") do
    #   xml.title channel.title
    #   xml.description translation_for_subcategory("cz", channel.description)
    # end
    # xml.language(:id => "hu") do
    #   xml.title channel.title
    #   xml.description translation_for_subcategory("hu", channel.description)
    # end
    # xml.language(:id => "pl") do
    #   xml.title channel.title
    #   xml.description translation_for_subcategory("po", channel.description)
    # end
    # xml.language(:id => "sk") do
    #   xml.title channel.title
    #   xml.description translation_for_subcategory("sk", channel.description)
    # end
    # xml.language(:id => "ro") do
    #   xml.title channel.title
    #   xml.description translation_for_subcategory("ro", channel.description)
    # end
    # xml.language(:id => "tr") do
    #   xml.title channel.title
    #   xml.description translation_for_subcategory("tr", channel.description)
    # end
  end

  xml << render( :partial => 'category_navigation', :locals => { :categories => channel.categories.arrange(:order => :title)})

end
