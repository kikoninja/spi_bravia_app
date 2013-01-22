categories.map do |category, subcategories|
  xml.category(:id => category.id, :style => category.style) do
    xml.default_icons do
      xml.icon_std "#{APP_SETTINGS[Rails.env]['affiliation_url']}#{category.icon.url(:small)}"
    end
    xml.languages do
      xml.language(:id => "en") do
        xml.title category.title
        xml.description "- #{package.description}"
      end
      xml.language(:id => "cs") do
        xml.title category.title
        xml.description "- #{package.description}"
      end
      xml.language(:id => "hu") do
        xml.title category.title
        xml.description "- #{package.description}"
      end
      xml.language(:id => "pl") do
        xml.title category.title
        xml.description "- #{package.description}"
      end
      xml.language(:id => "sk") do
        xml.title category.title
        xml.description "- #{package.description}"
      end
      xml.language(:id => "ro") do
        xml.title category.title
        xml.description "- #{package.description}"
      end
      xml.language(:id => "tr") do
        xml.title category.title
        xml.description "- #{package.description}"
      end
    end
    xml << render( :partial => 'category_navigation', :locals => { :categories => subcategories})
  end
end

