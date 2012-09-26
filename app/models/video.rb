class Video < ActiveRecord::Base
  use_connection_ninja(:controlcenter)

  # Associations
  has_one :asset
  has_many :video_custom_attributes

  # Scopes
  default_scope where('user_id =?', 5842)


  def genres
    genres = video_custom_attributes.where(attribute_name: 'genres_en').first

    if genres
      return genres.attribute_value
    else
      return ""
    end
  end

end
