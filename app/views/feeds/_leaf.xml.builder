xml.assets do
  feed.assets.each do |asset|
    xml.asset(:id => asset.content_id, :pay_content => asset.pay_content ) do
      asset.categories.each do |category|
        xml.in_category(:id => category.id)
      end
      xml.type asset.asset_type
      xml.default_icons do
        xml.icon_std thumbnail(asset.video_id)
      end
      xml.languages do
        xml.language(:id => "en") do
          #xml.title asset.title
          #xml.description asset.description
          xml.title asset.video.title
          xml.description asset.video.description
          xml.icon_std thumbnail(asset.video_id)
        end
      end
      xml.asset_url("#{asset.video.source_url}", :downloadable => "false")
      #xml.rating("#{rating(asset.video_id)}", :scheme => "urn:v-chip")
      xml.rating("NR", :scheme => "urn:v-chip")
      xml.duration asset.duration
    end
  end
end
