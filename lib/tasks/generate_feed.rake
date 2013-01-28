namespace :feed do
  namespace :generate do

    desc "Generate all feeds (both video and hls)"
    task :all => :environment do
      Rake::Task["feed:generate:videos"].execute 
      Rake::Task["feed:generate:hls"].execute 
    end

    desc "Generate feeds from the videos in the database"
    task :videos => :environment do
      # Cleanup the old data
      cleanup_old_data

      # Select the main channel
      channel = Channel.first

      # Generate the feeds
      generate_feeds(channel)

      # Generate publishers

      PUBLISHERS = [{:publisher_id => 5842, :cc => "PL", :region_id => 1}, 
                    {:publisher_id => 25131, :cc => "HU", :region_id => 2}, 
                    {:publisher_id => 25132, :cc => "TR", :region_id => 3}, 
                    {:publisher_id => 25136, :cc => "CZ", :region_id => 4}, 
                    {:publisher_id => 25137, :cc => "RO", :region_id => 5}]

      PUBLISHERS.each do |publisher|
        Publisher.create!(
          :publisher_id => publisher[:id], 
          :country_code => publisher[:cc],
          :region_id => publisher[:region_id]
          )
      end

      Publisher.all.each do |publisher|
        # Load the package config
        packages_config = YAML.load_file("config/packages_#{publisher.country_code}.yml")
        # Load hls_videos
        hls_videos = Video.where(:publisher_id => publisher.publisher_id, :live => '1')

          # Iterate through packages from the config
          packages_config.each do |package_id, value|
            # Print some info
            print "Processing package... #{package_id}"
            print "Package Publisher... #{publisher.publisher_id} / #{publisher.country_code}"
            package = Package.find_by_external_id(package_id)
            puts "(#{package.videos.count} videos, #{packages_config[package_id].length} categories)"

            # Create category for this package
            print " - creating category #{package.name}..."
            category = create_category(package, channel)
            puts "done"

            # Create the subcategories
            packages_config[package_id].each do |category_id, category_data|
              print "   - creating subcategory #{category_id.humanize}..."
              subcategory = Category.create!(
                title: category_id.humanize,
                description: "Insert genre description here",
                style: "tile",
                icon: generate_icon_path(category_id, category_data),
                parent: category,
                channel: channel
              )
              puts "done"
            end

            # Iterate through videos, create assets and attach them to category
            package.videos.each_with_index do |video, index|
              # Create the asset
              asset = create_asset_from_video(video, package)
              puts "    - created asset for video #{video.title} with asset ID: #{asset.content_id} for Publisher: #{publisher.publisher_id}" 

              # Categorize it
              genres = video.genres.split(",")
              categorization_count = 0
              genres.each do |genre|
                packages_config[package_id].each do |category_id, category_data|
                  if category_data["identifiers"].include? genre
                    subcategory = category.children.where(title: category_id.humanize).first
                    AssetCategorization.create!(:asset_id => asset.id, :category_id => subcategory.id)
                    puts "       - attaching the asset to subcategory #{subcategory.title}"
                    categorization_count = categorization_count + 1
                  end
                end
              end

              if categorization_count == 0
                AssetCategorization.create!(:asset_id => asset.id, :category_id => category.id)
                puts "       - Warning: Genres #{video.genres} not found in this package, attaching the asset to category #{category.title} instead"
              end
              categorization_count = 0
            end
          end
          desc "Generate feeds for HLS"
          task :hls => :environment do
            # Delete the hls feed
            old_leaf = Feed.find_by_title("2m_leaf1_2")
            if old_leaf
              old_leaf.destroy 
              puts "Deleted the feed leaf: 2m_leaf1_2"
            end

            channel = Channel.first
            feed_leaf2 = Feed.create!(:channel => channel, :title => "2m_leaf1_2")
            puts "- created feed: #{feed_leaf2.title}"

            #puts "Generating manual feeds for HLS"
            #hls_assets = []
            #base_uri = APP_SETTINGS[Rails.env]['base_logo_uri']
            
            # # Define all the hls assets
            # kinopolska_asset = HlsAsset.new("01", "Pakiet Kino Polska", "KinoPolska Live Package", "#{asset_description}", "#{base_uri}kinopolska.png", "http://spiinternational-i.akamaihd.net/hls/live/204304/KINOPOLSKA_PL_HLS/once1200.m3u8")
            # hls_assets << kinopolska_asset

            # docubox_asset = HlsAsset.new("02", "Pakiet DocuBox", "DocuBox Live Package", "#{asset_description}", "#{base_uri}docubox.png", "http://spiinternational-i.akamaihd.net/hls/live/204306/DOCUBOXHD_MT_HLS/once1200.m3u8")
            # hls_assets << docubox_asset

            # fashionbox_asset = HlsAsset.new("03", "Pakiet FashionBox", "FashionBox Live Package", "#{asset_description}", "#{base_uri}fashionbox.png", "http://spiinternational-i.akamaihd.net/hls/live/204307/FASHIONBOXHD_MT_HLS/once1200.m3u8")
            # hls_assets << fashionbox_asset

            # filmbox_asset = HlsAsset.new("04", "Pakiet Film", "FilmBox", "#{asset_description}", "#{base_uri}filmbox.png", "http://spiinternational-i.akamaihd.net/hls/live/204302/FILMBOXBASIC_PL_HLS/once1200.m3u8")
            # hls_assets << filmbox_asset

            # filmbox_prem_asset = HlsAsset.new("05", "Pakiet Full", "FilmBox Premiere", "#{asset_description}", "#{base_uri}filmbox_prem.png", "http://spiinternational-i.akamaihd.net/hls/live/204303/FILMBOXEXTRA_PL_HLS/once1200.m3u8")
            # hls_assets << filmbox_prem_asset

            # fightbox_asset = HlsAsset.new("06", "Pakiet FightBox", "FightBox Live Package", "#{asset_description}", "#{base_uri}fightbox.png", "http://spiinternational-i.akamaihd.net/hls/live/204308/FIGHTBOXHD_MT_HLS/once1200.m3u8")
            # hls_assets << fightbox_asset

            # hls_assets.each do |hls_asset|
            #   category = Category.find_by_title(hls_asset.category_title)

            #   asset = Asset.create!(
            #     :title => hls_asset.asset_title,
            #     :feed => feed_leaf2,
            #     :content_id => "hls-asset-#{hls_asset.id}",
            #     :pay_content => "true",
            #     :asset_type => "video",
            #     :duration => 0,
            #     :asset_description => hls_asset.asset_description,
            #     :thumbnail_url => hls_asset.thumbnail_url,
            #     :live => true,
            #     :source_url => hls_asset.source_url,
            #     :rating => "15" 
            #   )
            #   puts "- created asset for HLS link for #{asset.title} with asset ID: #{asset.content_id}"

            #   AssetCategorization.create!(:asset_id => asset.id, :category_id => category.id)
            # end

          end

      end
    end
  end
      
end

class HlsAsset

  attr_accessor :id, :category_title, :asset_title, :asset_description, :thumbnail_url, :source_url

  def initialize(id, category_title, asset_title, asset_description, thumbnail_url, source_url)
    @id = id
    @category_title = category_title
    @asset_title = asset_title
    @asset_description = asset_description
    @thumbnail_url = thumbnail_url
    @source_url = source_url
  end

end

def cleanup_old_data
  Category.delete_all
  puts "Deleted old categories..."
  Feed.delete_all
  puts "Deleted old feeds..."
  Asset.delete_all
  puts "Deleted old assets..."
  AssetCategorization.delete_all
  puts "Deleted old categorizations..."
end

def generate_feeds(channel)
  @feed_branch = Feed.create!(:channel => channel, :title => "branch")
  puts "- created feed: #{@feed_branch.title}"
  @feed_leaf1 = Feed.create!(:channel => channel, :title => "2m_leaf1_1")
  puts "- created feed: #{@feed_leaf1.title}"
  @feed_leaf3 = Feed.create!(:channel => channel, :title => "2m_leaf1_3")
  puts "- created feed: #{@feed_leaf3.title}"
end

def create_category(package, channel)
  category = Category.create!(
    :title => package.name,
    :description => package.description,
    :style => "tile",
    :icon => package.image_url,
    :channel => channel
  ) 
end

def create_asset_from_video(video, package)
  asset = Asset.create!(
    :title => video.title,
    :description => video.description,
    :feed => @feed_leaf1,
    :content_id => "#{package.id}-asset-#{video.id}",
    :pay_content => true,
    :asset_type => "video",
    :video_id => video.id,
    :duration => video.duration,
    :thumbnail_url => thumbnail(video),
    :live => check_live(video),
    :source_url => source_url(video),
    :rating => rating(video)
  )
end

def generate_icon_path(category_id, category_data)
  File.open("#{Rails.root}/public/images/icons/#{category_data['icon_name']}")
rescue
  print "Warning: Icon not found for genre: #{category_id}... "
  File.open("#{Rails.root}/log/feed.log", 'a') do |f|
    f.write("Icon not found for genre: #{category_id}\n")
  end
  return ""
end

def thumbnail(video)
  image_url = video.video_custom_attributes.where('attribute_name =?', 'thumbnail').first.try(:attribute_value)
  if image_url.blank?
    return "http://bivlspidev.invideous.com/images/missing-icon.png"
  else
    return image_url
  end
end

def check_live(video)
  return true if video.live == "1"
end

def source_url(video)
  #VideoCustomAttribute.where('video_id =? && attribute_name =?', video_id, 'sony_source_url').first.attribute_value
  guid = video.video_custom_attributes.where('attribute_name =?', 'guid').first.try(:attribute_value)
  url = "http://once.unicornmedia.com/now/stitched/mp4/9a48dc3b-f49b-4d69-88e2-8bff2784d44b/ff3177e5-169a-495e-a8c6-47b145470cdd/3a41c6e4-93a3-4108-8995-64ffca7b9106/#{guid}/content.mp4"
end

def rating(video)
  rating = video.video_custom_attributes.where('attribute_name =?', 'rating_pl').first
  if rating
    rating.attribute_value
  else
    "15"
  end
end
