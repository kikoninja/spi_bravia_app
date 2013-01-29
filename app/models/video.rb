class Video < ActiveRecord::Base
  use_connection_ninja(:controlcenter)

  # Associations
  has_one :asset
  has_many :video_custom_attributes 

  # Scopes
  #default_scope where('user_id =?', 5842)


  def genres
    genres = fetch_attribute("genres_en")
    if genres
      return genres
    else
      return ""
    end
  end

  def duration
    duration_attribute = fetch_attribute("duration")
    # duration_attribute = video_custom_attributes.where(attribute_name: "duration").first
    if duration_attribute
      convert_time_to_seconds(duration_attribute) * 60
    else
      0
    end
  end

  def rating
    rating = fetch_attribute("rating_pl")
    if rating
      rating
    else
      "15"
    end
  end
  

  private

  def convert_time_to_seconds(time)
    a = [1, 60] * 2
    time.split(/[:\.]/).map{|time| time.to_i*a.pop}.inject(&:+)
  end

  def fetch_attribute(attr_name)
    self.video_custom_attributes.map { |attr| attr.attribute_value if attr.attribute_name == attr_name }.compact.first
  end

end
