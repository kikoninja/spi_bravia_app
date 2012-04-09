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
      xml.icon_std thumbnail(asset.video_id)
      xml.asset_url(:downloadable => "false") do
        xml.text! asset.video.source_url
      end
      xml.duration asset.duration
    end
  end
end
