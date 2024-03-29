xml.assets do
  feed.assets.each do |asset|
    xml.asset(:id => asset.content_id, :pay_content => asset.pay_content ) do
      asset.categories.arrange(:order => :id).map do |category, subcategories|
        if subcategories.empty?
          xml.in_category(:id => category.id)
        else
          subcategories.map do |subcategory|
            xml.region_ref(:id => category.region_ref)
            xml.in_category(:id => subcategory.first.id)
          end
        end
      end
      if asset.asset_type == "video" 
        xml.type asset.asset_type
        xml.default_icons do
          xml.icon_std asset.thumbnail_url
        end
        xml.languages do
          xml.language(:id => "en") do
            #xml.title asset.title
            #xml.description asset.description
            xml.title asset.title
            xml.description "- #{asset.description}"
            xml.icon_std asset.thumbnail_url
          end
          # xml.language(:id => "cs") do
          #   #xml.title asset.title
          #   #xml.description asset.description
          #   xml.title asset.title
          #   xml.description "- #{asset.description}"
          #   xml.icon_std asset.thumbnail_url
          # end
          # xml.language(:id => "hu") do
          #   #xml.title asset.title
          #   #xml.description asset.description
          #   xml.title asset.title
          #   xml.description "- #{asset.description}"
          #   xml.icon_std asset.thumbnail_url
          # end
          # xml.language(:id => "pl") do
          #   #xml.title asset.title
          #   #xml.description asset.description
          #   xml.title asset.title
          #   xml.description "- #{asset.description}"
          #   xml.icon_std asset.thumbnail_url
          # end
          # xml.language(:id => "sk") do
          #   #xml.title asset.title
          #   #xml.description asset.description
          #   xml.title asset.title
          #   xml.description "- #{asset.description}"
          #   xml.icon_std asset.thumbnail_url
          # end
          # xml.language(:id => "ro") do
          #   #xml.title asset.title
          #   #xml.description asset.description
          #   xml.title asset.title
          #   xml.description "- #{asset.description}"
          #   xml.icon_std asset.thumbnail_url
          # end
          # xml.language(:id => "tr") do
          #   #xml.title asset.title
          #   #xml.description asset.description
          #   xml.title asset.title
          #   xml.description "- #{asset.description}"
          #   xml.icon_std asset.thumbnail_url
          # end
        end
        xml.asset_url("#{asset.source_url}", :downloadable => "false")
        xml.rating("0", :scheme => "urn:age")
        xml.duration asset.duration
        if asset.live
          xml.stream_type "HTTPLS"
          xml.metafile_type "m3u8"
          xml.container_type "MPEG2TS"
          xml.video_type "MPEG2"
          xml.audio_type "AAC-LC"
        end
      end
    end
  end
end
