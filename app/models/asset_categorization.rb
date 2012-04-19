class AssetCategorization < ActiveRecord::Base

  # Associations
  belongs_to :asset
  belongs_to :category

  attr_accessible :asset_id, :category_id

  after_update :add_categories

  private

    def add_categories
      genres = asset.video.video_custom_attributes.where('attribute_name =?', 'genres_pl').first.attribute_value
      genres = genres.split(",")
      genres.each do |genre|
        if Category.where("title =?", genre.capitalize).empty?
          category = Category.new(:title => genre.capitalize, :description => "All #{genre} movies", :style => "title", :order => Category.last.order + 1, :icon => File.open("app/assets/images/#{genre}_icon.png"), :parent_id => asset_id)
          category.save
        end
      end
    end

end
