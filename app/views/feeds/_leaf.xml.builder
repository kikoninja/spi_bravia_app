xml.assets do
  feed.assets.each do |asset|
    xml.asset(:id => asset.content_id, :pay_content => asset.pay_content ) do
      xml.type asset.asset_type
      xml.languages do
        xml.language(:id => "en") do
          xml.title asset.title
          xml.description asset.description
        end
      end
      xml.duration asset.duration
    end
  end
end
