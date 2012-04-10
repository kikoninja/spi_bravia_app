module ApplicationHelper
require 'digest/md5'

  def make_URL(baseurl, service_name, feed_id, secret_key)
      url = baseurl + "?service_name=" + url_encode(service_name) + "&method=fromFeed&feed_id=" + feed_id + "&timestamp=" + url_encode(makeRFC3339(Time.now))
      sig = Digest::MD5.hexdigest(url+secret_key)
      url += "&sig=" + sig
  end

  def makeRFC3339(timestamp)
    timestring = timestamp.xmlschema
  end

  def thumbnail(video_id)
    VideoCustomAttribute.where('video_id =? && attribute_name =?', video_id, 'thumbnail').first.attribute_value
  end

  def rating(video_id)
    rating = VideoCustomAttribute.where('video_id =? && attribute_name =?', video_id, 'rating_pl').first.attribute_value.to_i
    if rating < 9
      "G"
    elsif rating >= 10 && rating <= 12
      "PG"
    elsif rating > 12 && rating <= 16
      "PG-13"
    elsif rating == 17
      "R"
    elsif rating > 17 && rating <=21
      "NC-17"
    else
      "NR"
    end
  end

  def source_url(video_id)
    VideoCustomAttribute.where('video_id =? && attribute_name =?', video_id, 'sony_source_url').first.attribute_value
  end
end
