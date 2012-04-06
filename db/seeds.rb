puts 'Setting seeds for your environment'

User.delete_all
Channel.delete_all
Category.delete_all
Feed.delete_all
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
category1 = Category.create!(:title => "Category #1", :description => "Description for category #1", :style => "tile", :order => 1, :channel => channel)
puts "- created category: #{category1.title}"
category2 = Category.create!(:title => "Category #2", :description => "Description for category #2", :style => "tile", :order => 2, :channel => channel)
puts "- created category: #{category2.title}"
category3 = Category.create!(:title => "Category #3", :description => "Description for category #3", :style => "tile", :order => 3, :channel => channel)
puts "- created category: #{category3.title}"

# Feeds
feed_branch = Feed.create!(:title => "branch")
puts "- created feed: #{feed_branch.title}"
feed_leaf1 = Feed.create!(:title => "2m_leaf1_1")
puts "- created feed: #{feed_leaf1.title}"
feed_leaf2 = Feed.create!(:title => "2m_leaf1_2")
puts "- created feed: #{feed_leaf2.title}"
feed_leaf3 = Feed.create!(:title => "2m_leaf1_3")
puts "- created feed: #{feed_leaf3.title}"


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
