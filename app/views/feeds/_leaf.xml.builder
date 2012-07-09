xml.assets do
  feed.assets.each do |asset|
    xml.asset(:id => asset.content_id, :pay_content => asset.pay_content ) do
      asset.categories.arrange(:order => :id).map do |category, subcategories|
        if subcategories.empty?
          xml.in_category(:id => category.id)
        else
          subcategories.map do |subcategory|
            xml.in_category(:id => subcategory.first.id)
          end
        end
      end
      if asset.asset_type == "video" && asset.video
        xml.type asset.asset_type
        xml.default_icons do
          xml.icon_std thumbnail(asset.video)
        end
        xml.languages do
          xml.language(:id => "en") do
            #xml.title asset.title
            #xml.description asset.description
            xml.title asset.video.title
            xml.description asset.video.description
            xml.icon_std thumbnail(asset.video)
          end
        end
        xml.asset_url("#{source_url(asset.video)}", :downloadable => "false")
        xml.rating("#{rating(asset.video)}", :scheme => "urn:age")
        xml.duration asset.duration
      end
    end
  end
end
