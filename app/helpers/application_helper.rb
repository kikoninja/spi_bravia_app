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
    VideoCustomAttribute.where('video_id =? && attribute_name =?', video_id, 'rating_pl').first.attribute_value
  end

  def source_url(video_id)
    VideoCustomAttribute.where('video_id =? && attribute_name =?', video_id, 'sony_source_url').first.attribute_value
  end
end
