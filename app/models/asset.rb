class Asset < ActiveRecord::Base

  TYPES = [ "video", "audio", "message", "icon" ]

  # Associations
  belongs_to :feed
  belongs_to :video
  has_and_belongs_to_many :categories, :join_table => :asset_categorizations

  attr_accessible :feed, :feed_id, :asset_type, :content_id, :description, :duration, :pay_content, :title, :video_id, :categories, :category_ids

  # Callbacks
  after_save :add_asset_categories
  after_save :update_title
  after_save :update_description

  private

    def add_asset_categories
      genres = video.video_custom_attributes.where('attribute_name =?', 'genres_pl').first.attribute_value
      genres = genres.split(",")
      genres.each do |genre|
        categories.where("ancestry !=?", "").each do |category|
          if Category.where("title =? AND ancestry =?", genre.capitalize, category.ancestry).empty?
            asset_category = Category.new(:title => genre.capitalize, :description => "All #{genre} movies", :style => "title", :order => Category.last.order + 1, :icon => File.open("app/assets/images/#{genre}_icon.png"), :parent_id => category.id)
            asset_category.save
          else
            asset_category = Category.where("title =? AND ancestry =?", genre.capitalize, category.ancestry).first
          end
          asset_categorization = AssetCategorization.new(:asset_id => id, :category_id => asset_category.id)
          asset_categorization.save
        end
      end
    end

    def update_title
      if title.blank? && video.title.present?
        update_attribute(:title, video.title)
      end
    end

    def update_description
      if description.blank? && video.description.present?
        update_attribute(:description, video.description)
      end
    end

end
