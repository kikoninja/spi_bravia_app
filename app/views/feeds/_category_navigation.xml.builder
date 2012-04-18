categories.map do |category, subcategories|
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
    xml << render( :partial => 'category_navigation', :locals => { :categories => subcategories})
  end
end

