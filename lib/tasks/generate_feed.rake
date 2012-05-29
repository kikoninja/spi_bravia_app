namespace :feed do
  desc "Read the database and generate the feed"
  task :generate => :environment do
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
    feed_leaf2 = Feed.create!(:channel => channel, :title => "2m_leaf1_2")
    puts "- created feed: #{feed_leaf2.title}"
    feed_leaf3 = Feed.create!(:channel => channel, :title => "2m_leaf1_3")
    puts "- created feed: #{feed_leaf3.title}"

    Package.all.each do |package|
      # Generating the main category
      category = Category.create!(
        :title => package.name,
        :description => package.description,
        :style => "tile",
        :channel => channel
      )
      puts "Created category #{category.title}"

      # Generate assets from videos and attach them to the category
      package.videos.each_with_index do |video, index|
        asset = Asset.create!(
          :title => video.title,
          :feed => feed_leaf1,
          :content_id => "#{package.id}-asset-#{video.id}",
          :pay_content => true,
          :asset_type => "video",
          :video_id => video.id,
          :duration => 1
        )

        puts "- created asset for video #{video.title} with asset ID: #{asset.content_id}"

        AssetCategorization.create!(:asset_id => asset.id, :category_id => category.id)
      end

    end
  end
end
