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

  def thumbnail(video)
    image_url = video.video_custom_attributes.where('attribute_name =?', 'thumbnail').first.try(:attribute_value)
    if image_url.blank?
      return "http://bivlspidev.invideous.com/images/missing-icon.png"
    else
      return image_url
    end
  end

  def rating(video)
    rating = video.video_custom_attributes.where('attribute_name =?', 'rating_pl').first
    if rating
      rating.attribute_value
    else
      "15"
    end
  end

  def source_url(video)
    #VideoCustomAttribute.where('video_id =? && attribute_name =?', video_id, 'sony_source_url').first.attribute_value
    guid = video.video_custom_attributes.where('attribute_name =?', 'guid').first.try(:attribute_value)
    url = "http://once.unicornmedia.com/now/stitched/mp4/9a48dc3b-f49b-4d69-88e2-8bff2784d44b/ff3177e5-169a-495e-a8c6-47b145470cdd/3a41c6e4-93a3-4108-8995-64ffca7b9106/#{guid}/content.mp4"
  end

  def calculate_signature(parameters)
    base_url = "https://spibivl.invideous.com/bivldev/sts_get_authorization/STSgetAuthorization/?"
    parameter_list = "id=#{parameters[:id]}&language=#{parameters[:language]}&service_name=#{parameters[:service_name]}&provider=#{parameters[:provider]}&ip_address=#{parameters[:ip_address]}&suit=#{parameters[:suit]}&esn=#{parameters[:esn]}&type=#{parameters[:type]}&reg_status=#{parameters[:reg_status]}&ui_type=#{parameters[:ui_type]}&request_timestamp=#{Rack::Utils.escape(parameters[:request_timestamp])}"
    url = base_url + parameter_list
    puts url
    sig = Digest::MD5.hexdigest(url + "wa1Kev6guokaiduu4iec")
  end

end
