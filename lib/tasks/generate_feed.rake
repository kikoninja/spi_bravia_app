namespace :feed do
  namespace :generate do
    
    desc "Generate all feeds from the database"
    task :all => :environment do
      # TODO: Invoke other tasks here
    end

    desc "Generate feeds from the videos in the database"
    task :video => :environment do
      # Delete the previous data
      Category.delete_all
      puts "Deleted old categories..."
      Feed.delete_all
      puts "Deleted old feeds..."
      Asset.delete_all
      puts "Deleted old assets..."
      AssetCategorization.delete_all
      puts "Deleted old categorizations..."

      channel = Channel.first

      # Generate the feeds
      feed_branch = Feed.create!(:channel => channel, :title => "branch")
      puts "- created feed: #{feed_branch.title}"
      feed_leaf1 = Feed.create!(:channel => channel, :title => "2m_leaf1_1")
      puts "- created feed: #{feed_leaf1.title}"

      feed_leaf3 = Feed.create!(:channel => channel, :title => "2m_leaf1_3")
      puts "- created feed: #{feed_leaf3.title}"

      Package.all.each do |package|
        # Generating the main category
        category = Category.create!(
          :title => package.name,
          :description => package.description,
          :style => "tile",
          :remote_icon_url => package.image_url,
          :channel => channel
        )
        puts "Created category #{category.title}"

        # Generate the genre subcategories
        ["Drama", "Comedy", "Romance", "Action", "Horror", "Sci-Fi", "Family", "Animation", "Kids"].each do |genre|
          subcategory = Category.create!(
            title: genre,
            description: "Insert genre description here",
            style: "tile",
            remote_icon_url: "http://w4.invideous.com/demo/Invideous_for_SPI_Sony_ServiceDefinition_11.03.2012/icons_sony/86x36/filmboxlive_86x36.png",
            parent: category,
            channel: channel
          )

          puts "- created subcategory #{subcategory.title}"
        end

        # Generate assets from videos and attach them to the category
        package.videos.each_with_index do |video, index|
          asset = Asset.create!(
            :title => video.title,
            :description => video.description,
            :feed => feed_leaf1,
            :content_id => "#{package.id}-asset-#{video.id}",
            :pay_content => true,
            :asset_type => "video",
            :video_id => video.id,
            :duration => 200,
            :thumbnail_url => thumbnail(video),
            :live => check_live(video),
            :source_url => source_url(video),
            :rating => rating(video)
          )

          puts "- created asset for video #{video.title} with asset ID: #{asset.content_id}"

          AssetCategorization.create!(:asset_id => asset.id, :category_id => category.id)
        end
      end
    end

    desc "Generate feeds from the HLS sources"
    task :hls => :environment do
      channel = Channel.first
      feed_leaf2 = Feed.create!(:channel => channel, :title => "2m_leaf1_2")
      puts "- created feed: #{feed_leaf2.title}"

      puts "Generating manual feeds for HLS"
      hls_assets = []
!y!0
      base_uri = APP_SETTINGS[Rails.env]['base_logo_uri']
      
      # Define all the hls assets
      kinopolska_asset = HlsAsset.new("01", "Pakiet Kino Polska", "KinoPolska Live Package", "kinopolska.png", "http://spiinternational-i.akamaihd.net/hls/live/204304/KINOPOLSKA_PL_HLS/once1200.m3u8")
      hls_assets << kinopolska_asset

      docubox_asset = HlsAsset.new("02", "Pakiet DocuBox", "DocuBox Live Package", "#{base_uri}docubox.png", "http://spiinternational-i.akamaihd.net/hls/live/204306/DOCUBOXHD_MT_HLS/once1200.m3u8")
      hls_assets << docubox_asset

      fashionbox_asset = HlsAsset.new("03", "Pakiet FashionBox", "FashionBox Live Package", "#{base_uri}fashionbox.png", "http://spiinternational-i.akamaihd.net/hls/live/204307/FASHIONBOXHD_MT_HLS/once1200.m3u8")
      hls_assets << fashionbox_asset

      filmbox_asset = HlsAsset.new("04", "Pakiet Film", "FilmBox", "#{base_uri}filmbox.png", "http://spiinternational-i.akamaihd.net/hls/live/204302/FILMBOXBASIC_PL_HLS/once1200.m3u8")
      hls_assets << filmbox_asset

      filmbox_prem_asset = HlsAsset.new("05", "Pakiet Full", "FilmBox Premiere", "#{base_uri}filmbox_prem.png", "http://spiinternational-i.akamaihd.net/hls/live/204303/FILMBOXEXTRA_PL_HLS/once1200.m3u8")
      hls_assets << filmbox_prem_asset

      fightbox_asset = HlsAsset.new("06", "Pakiet FightBox", "FightBox Live Package", "#{base_uri}fightbox.png", "http://spiinternational-i.akamaihd.net/hls/live/204308/FIGHTBOXHD_MT_HLS/once1200.m3u8")
      hls_assets << fightbox_asset

      hls_assets.each do |hls_asset|
        category = Category.find_by_title(hls_asset.category_title)

        asset = Asset.create!(
          :title => hls_asset.asset_title,
          :feed => feed_leaf2,
          :content_id => "hls-asset-#{hls_asset.id}",
          :pay_content => "true",
          :asset_type => "video",
          :duration => 200,
          :thumbnail_url => hls_asset.thumbnail_url,
          :live => true,
          :source_url => hls_asset.source_url,
          :rating => "15" 
        )
        puts "- created asset for HLS link for #{asset.title} with asset ID: #{asset.content_id}"

        AssetCategorization.create!(:asset_id => asset.id, :category_id => category.id)
      end

  end

end

class HlsAsset

  attr_accessor :id, :category_title, :asset_title, :thumbnail_url, :source_url

  def initialize(id, category_title, asset_title, thumbnail_url, source_url)
    @id = id
    @category_title = category_title
    @asset_title = asset_title
    @thumbnail_url = thumbnail_url
    @source_url = source_url
  end

end

end

def check_live(video)
  return true if video.live == "1"
end

def thumbnail(video)
  image_url = video.video_custom_attributes.where('attribute_name =?', 'thumbnail').first.try(:attribute_value)
  if image_url.blank?
    return "http://bivlspidev.invideous.com/images/missing-icon.png"
  else
    return image_url
  end
end

def rating(video)
  rating = video.video_custom_attributes.where('attribute_name =?', 'rating_pl').first
  if rating
    rating.attribute_value
  else
    "15"
  end
end

def source_url(video)
  #VideoCustomAttribute.where('video_id =? && attribute_name =?', video_id, 'sony_source_url').first.attribute_value
  guid = video.video_custom_attributes.where('attribute_name =?', 'guid').first.try(:attribute_value)
  url = "http://once.unicornmedia.com/now/stitched/mp4/9a48dc3b-f49b-4d69-88e2-8bff2784d44b/ff3177e5-169a-495e-a8c6-47b145470cdd/3a41c6e4-93a3-4108-8995-64ffca7b9106/#{guid}/content.mp4"
end

