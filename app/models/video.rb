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
    if duration_attribute.present?
      convert_time_to_seconds(duration_attribute) * 60
    else
      0
    end
  end

  def thumbnail
    image_url = fetch_attribute("thumbnail")
    if image_url.blank?
      "http://bivlspidev.invideous.com/images/missing-icon.png"
    else
      image_url
    end
  end

  def source_url
    guid = fetch_attribute("guid")
    url = "http://once.unicornmedia.com/now/stitched/mp4/9a48dc3b-f49b-4d69-88e2-8bff2784d44b/ff3177e5-169a-495e-a8c6-47b145470cdd/3a41c6e4-93a3-4108-8995-64ffca7b9106/#{guid}/content.mp4"
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
