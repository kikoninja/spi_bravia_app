class SignatureCalculator

  def initialize(url, inbound_key)
    @url = url
    @inbound_key = inbound_key
  end

  def calculate_sig
    @url = reject_param(@url, 'sig')
    @url = inject_char_before('?', '/')
    sig = Digest::MD5.hexdigest(@url + @inbound_key)
  end

  private

  def reject_param(url, param_to_reject)
    # Regex from RFC3986
    url_regex = %r"^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?$"
    raise "Not a url: #{url}" unless url =~ url_regex
    scheme_plus_punctuation = $1
    authority_with_punctuation = $3
    path = $5
    query = $7
    fragment = $9
    query = query.split('&').reject do |param|
      param_name = param.split(/[=;]/).first
      param_name == param_to_reject
    end.join('&')
    [scheme_plus_punctuation, authority_with_punctuation, path, '?', query, fragment].join
  end  
 
  def inject_char_before(char, added_char)
    @url.sub!(char, "#{added_char}#{char}" )
  end
  
end
