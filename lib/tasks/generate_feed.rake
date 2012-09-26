namespace :feed do
  namespace :generate do

    desc "Generate feeds from the videos in the database"
    task :videos => :environment do
      # Cleanup the old data
      cleanup_old_data

      # Select the main channel
      channel = Channel.first

      # Generate the feeds
      generate_feeds(channel)

      # Load the package config
      packages_config = YAML.load_file('config/packages.yml')

      # Iterate through packages from the config
      packages_config.each do |package_id, value|
        # Print some info
        print "Processing package... #{package_id}"
        package = Package.find_by_external_id(package_id)
        puts " (#{package.videos.count} videos, #{packages_config[package_id].length} categories)"

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
          puts "    - created asset for video #{video.title} with asset ID: #{asset.content_id}" 
          
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
    end

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
    :remote_icon_url => package.image_url,
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
    :duration => 200,
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
