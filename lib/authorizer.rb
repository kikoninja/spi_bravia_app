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
    parameter_names = [:id, :language, :service_name, :suit, :provider, :esn, :type, :reg_status, :ui_type, :request_timestamp, :sig]
    validate_parameters_present(parameter_names)
    # validate_suit(@parameters[:suit])
    validate_sig(@parameters[:sig])
    validate_request_timestamp(@parameters[:request_timestamp])
  end

  private

  def validate_sig(sig)
    @error_code = ERROR_SIG_INVALID unless @signature == sig
  end

  def validate_request_timestamp(request_timestamp)
    Date.parse(request_timestamp)
    true
  rescue
    @error_code = ERROR_REQUEST_TS_INVALID
  end

  def validate_suit(suit)
    @error_code = ERROR_AUTH_UNKNOWN unless @suit == suit
  end

  def validate_parameters_present(parameter_names)
    parameter_names.each do |name|
      unless @parameters[name]
        @error_code = ERROR_UNKNOWN_REQUEST
      end
    end
  end

end
