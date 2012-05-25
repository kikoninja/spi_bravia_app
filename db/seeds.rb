puts 'Setting seeds for your environment'

User.delete_all
Channel.delete_all
Category.delete_all
Feed.delete_all
Asset.delete_all
AssetCategorization.delete_all
puts "- deleted old data"

# Users
admin = User.create!(:username => 'admin', :email => 'admin@example.org',
                   :password => 'password')
admin.admin = true
admin.save
puts "- created admin user (user: admin@example.org / pass: password)"

# Channels
channel = Channel.create!(:title => "FilmBox PL", :description => "Description for Filmbox PL channel")
puts "- created default channel: #{channel.title}"

# Categories
category1 = Category.create!(:title => "Ultimate Package", :description => "Description for Ultimate Package",
                             :style => "tile", :order => 1, :channel => channel, :icon => File.open("db/seeds/resources/ultimate_package.png"))
puts "- created category: #{category1.title}"
category2 = Category.create!(:title => "Film Package", :description => "Description for Film Package",
                             :style => "tile", :order => 2, :channel => channel, :icon => File.open("db/seeds/resources/film_package.png"))
puts "- created category: #{category2.title}"
category3 = Category.create!(:title => "Polish Package", :description => "Description for category Polish Package",
                             :style => "tile", :order => 3, :channel => channel, :icon => File.open("db/seeds/resources/polish_package.png"))
puts "- created category: #{category3.title}"
category4 = Category.create!(:title => "Fight Box", :description => "Description for category Fight Box",
                             :style => "tile", :order => 4, :channel => channel, :icon => File.open("db/seeds/resources/fight_box.png"))
puts "- created category: #{category4.title}"
category5 = Category.create!(:title => "Docu Box", :description => "Description for category Docu Box",
                             :style => "tile", :order => 5, :channel => channel, :icon => File.open("db/seeds/resources/docu_box.png"))
puts "- created category: #{category5.title}"
category6 = Category.create!(:title => "Fashion Box", :description => "Description for category Fashion Box",
                             :style => "tile", :order => 6, :channel => channel, :icon => File.open("db/seeds/resources/fashion_box.png"))
puts "- created category: #{category6.title}"

# Feeds
feed_branch = Feed.create!(:channel_id => 1, :title => "branch")
puts "- created feed: #{feed_branch.title}"
feed_leaf1 = Feed.create!(:channel_id => 1, :title => "2m_leaf1_1")
puts "- created feed: #{feed_leaf1.title}"
feed_leaf2 = Feed.create!(:channel_id => 1, :title => "2m_leaf1_2")
puts "- created feed: #{feed_leaf2.title}"
feed_leaf3 = Feed.create!(:channel_id => 1, :title => "2m_leaf1_3")
puts "- created feed: #{feed_leaf3.title}"

# Assets
#asset1 = Asset.create!(:title => "Asset #1", :description => "Description for asset #1", :feed => feed_leaf1, :content_id => "something-1", :duration => 7200, :pay_content => false, :asset_type => "video", :video_id => '1606950')
#puts "- created asset: #{asset1.title}"
#asset2 = Asset.create!(:title => "Asset #2", :description => "Description for asset #2", :feed => feed_leaf1, :content_id => "something-2", :duration => 7200, :pay_content => false, :asset_type => "video", :video_id => '1606951')
#puts "- created asset: #{asset2.title}"
#asset3 = Asset.create!(:title => "Asset #3", :description => "Description for asset #3", :feed => feed_leaf1, :content_id => "something-3", :duration => 7200, :pay_content => false, :asset_type => "video", :video_id => '1606952')
#puts "- created asset: #{asset3.title}"

# Attach assets to categories
#asset1.categories << [category1, category2, category3]
#puts "- attached asset #{asset1.title} to category #{category1.title}"
#puts "- attached asset #{asset1.title} to category #{category2.title}"
#puts "- attached asset #{asset1.title} to category #{category3.title}"
#asset2.categories << [category2, category3]
#puts "- attached asset #{asset2.title} to category #{category2.title}"
#puts "- attached asset #{asset2.title} to category #{category3.title}"
#asset3.categories << [category3]
#puts "- attached asset #{asset3.title} to category #{category3.title}"

