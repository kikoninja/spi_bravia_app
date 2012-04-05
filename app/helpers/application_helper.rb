module ApplicationHelper
require 'open-uri'
require 'digest'

  def make_URL(baseurl, service_name, feed_id, secret_key)
      url = baseurl + "?service_name=" + URI::encode(service_name) + "&method=fromFeed&feed_id=" + feed_id + "&timestamp=" + URI::encode(makeRFC3339(Time.now))
      sig = Digest::MD5.hexdigest(url+secret_key)
      url += "&sig=" + sig
  end

  def makeRFC3339(timestamp)
    timestring = timestamp.xmlschema
  end

end
