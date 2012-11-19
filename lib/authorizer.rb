require 'date'

class Authorizer

  # Error codes
  SUCCESS = 0
  ERROR_UNKNOWN_REQUEST = 40
  ERROR_SIG_INVALID = -2002
  ERROR_AUTH_UNKNOWN = -2027
  ERROR_REQUEST_TS_INVALID = -2030 

  attr_accessor :error_code

  def initialize(signature, parameters)
    # @suit = suit
    @parameters = parameters
    @signature = signature
    @error_code = SUCCESS
  end

  def authorize
    begin
      parameter_names = [:id, :language, :service_name, :suit, :provider, :esn, :type, :reg_status, :ui_type, :request_timestamp, :sig]
      validate_parameters_present(parameter_names)
      # validate_suit(@parameters[:suit])
      validate_sig(@parameters[:sig])
      validate_request_timestamp(@parameters[:request_timestamp])
    rescue Exception
      # Do nothing
    end
  end

  def calculate_signature(url)
    url = reject_param(url, 'sig')
    puts url
    sig = Digest::MD5.hexdigest(url + "wa1Kev6guokaiduu4iec")
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

  def validate_sig(sig)
    @error_code = ERROR_SIG_INVALID unless @signature == sig
  end

  def validate_request_timestamp(request_timestamp)
    date = DateTime.parse(request_timestamp)
    if (date < DateTime.now + 5.minutes) && (date > DateTime.now - 5.minutes)
      true
    else
      @error_code = ERROR_REQUEST_TS_INVALID
    end
  rescue
    @error_code = ERROR_UNKNOWN_REQUEST
  end

  def validate_suit(suit)
    @error_code = ERROR_AUTH_UNKNOWN unless @suit == suit
  end

  def validate_parameters_present(parameter_names)
    parameter_names.each do |name|
      unless @parameters[name]
        @error_code = ERROR_UNKNOWN_REQUEST
        raise UnknownRequestException
      end
    end
  end

end

class UnknownRequestException < Exception
end
