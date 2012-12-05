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

  def validate_sig(sig)
    @error_code = ERROR_SIG_INVALID unless @signature == sig
  end

  def validate_request_timestamp(request_timestamp)
    puts "Validating request timestamp!"
    date = DateTime.parse(request_timestamp)
    puts "Validating date: #{(date < DateTime.now + 5.minutes) && (date > DateTime.now - 5.minutes)}"
    puts "tralalala"
    if (date < DateTime.now + 5.minutes) && (date > DateTime.now - 5.minutes)
      puts "Timestamp ok"
      return true
    else
      puts "Invalid timestamp!"
      @error_code = ERROR_REQUEST_TS_INVALID
    end
  rescue Exception => e
    puts "Rescuing from validate request timestamp: #{e.class}..."
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
