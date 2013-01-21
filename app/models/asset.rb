qclass Asset < ActiveRecord::Base

  TYPES = [ "video", "audio", "message", "icon" ]

  # Associations
  belongs_to :feed
  belongs_to :video
  has_and_belongs_to_many :categories, :join_table => :asset_categorizations, :uniq => true

  attr_accessible :feed, :feed_id, :asset_type, :content_id, :description, :duration, :pay_content, :title, :video_id, :categories, :category_ids, :thumbnail_url, :live, :source_url, :rating

  # Validations
  validates_presence_of :feed_id, :asset_type # video_id
  # validates_uniqueness_of :video_id

  # Callbacks
  after_save :add_asset_categories
  after_save :update_title
  after_save :update_description

  private

    def add_asset_categories
      genres = video.video_custom_attributes.where('attribute_name =?', 'genres_pl').first if video.present?
      if genres != nil
        genres = genres.attribute_value
        genres = genres.split(",")
        genres.each do |genre|
          categories.roots.each do |category|
            asset_categories = category.descendants
            asset_category = asset_categories.find_by_title(genre.capitalize)
            if asset_category.nil?
              asset_category = Category.new(:channel_id => feed.channel_id, :title => genre.capitalize, :description => "All #{genre} movies", :style => "tile", :order => Category.last.order + 1, :icon => File.open("app/assets/images/#{genre.downcase}_icon.png"), :parent_id => category.id)
              asset_category.save
            end
            asset_categorization = AssetCategorization.new(:asset_id => id, :category_id => asset_category.id)
            asset_categorization.save
          end
        end
      else
        categories.roots.each do |category|
          asset_categorization = AssetCategorization.new(:asset_id => id, :category_id => category.id)
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
      if description.blank? && video.present? && video.description.present?
        update_attribute(:description, video.description)
      end
      else
        update_attribute(:description, "Description missing")
      end
    end

end
