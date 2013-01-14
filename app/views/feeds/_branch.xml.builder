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
  xml.regions do
    xml.region(:id => 1) do
      xml.country("cz")
      xml.country("hu")
      xml.country("pl")
      xml.country("sk")
      xml.country("ro")
      xml.country("tr")
    end
    xml.region(:id => 2) do
      xml.country "cz" 
      xml.fallback_language "cz"
    end
    xml.region(:id => 3) do
      xml.country "hu"
      xml.fallback_language "hu"
    end
    xml.region(:id => 4) do
      xml.country "pl"
      xml.fallback_language "pl"
    end
    xml.region(:id => 5) do
      xml.country "sk"
      xml.fallback_language "sk"
    end
    xml.region(:id => 6) do
      xml.country("ro")
      xml.fallback_language "ro"
    end
    xml.region(:id => 7) do
      xml.country("tr")
      xml.fallback_language "tr"
    end
  end


  xml.languages do
    xml.language(:id => "en") do
      xml.region_ref(:id => 2)
      xml.title channel.title
      xml.description channel.description
    end
    xml.language(:id => "cz") do
      xml.region_ref(:id => 3)
      xml.title channel.title
      xml.description translation_for_subcategory("cz", channel.description)
    end
    xml.language(:id => "hu") do
      xml.region_ref(:id => 4)
      xml.title channel.title
      xml.description translation_for_subcategory("hu", channel.description)
    end
    xml.language(:id => "pl") do
      xml.region_ref(:id => 5)
      xml.title channel.title
      xml.description translation_for_subcategory("po", channel.description)
    end
    xml.language(:id => "sk") do
      xml.region_ref(:id => 6)
      xml.title channel.title
      xml.description translation_for_subcategory("sk", channel.description)
    end
    xml.language(:id => "ro") do
      xml.region_ref(:id => 7)
      xml.title channel.title
      xml.description translation_for_subcategory("ro", channel.description)
    end
    xml.language(:id => "tr") do
      xml.region_ref(:id => 8)
      xml.title channel.title
      xml.description translation_for_subcategory("tr", channel.description)
    end
  end

  xml << render( :partial => 'category_navigation', :locals => { :categories => channel.categories.arrange(:order => :title)})

end
