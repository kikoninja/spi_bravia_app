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

    Package.all.each do |package|
      # Generating the main category
      category = Category.create!(
        :title => package.name,
        :description => package.description,
        :style => "tile",
        :channel => channel
      )
      puts "Created category #{category.title}"
    end
  end
end
