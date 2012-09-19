categories.map do |category, subcategories|
  xml.category(:id => category.id, :style => category.style) do
    xml.default_icons do
      xml.icon_std "#{APP_SETTINGS[Rails.env]['affiliation_url']}#{category.icon.url(:small)}"
    end
    xml.languages do
      xml.language(:id => "en") do
        xml.title category.title
        xml.description category.description
      end
    end
    xml << render( :partial => 'category_navigation', :locals => { :categories => subcategories})
  end
end

