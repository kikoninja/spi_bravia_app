class Authorizer

  attr_accessor :error_code

  def initialize(suit, signature, parameters)
    @suit = suit
    @parameters = parameters
    @signature = signature
    @error_code = 0
  end

  def authorize
    if @parameters[:service_name]
      if @parameters[:suit] == @suit
        check_sig(@parameters[:sig])
        check_request_timestamp(@parameters[:request_timestamp])
      else
        @error_code = -2027
      end
    else
      @error_code = 40
    end
  end

  private

  def check_sig(sig)
    @error_code = -2002 unless @signature == sig
  end

  def check_request_timestamp(request_timestamp)
    Date.parse(request_timestamp)
    true
  rescue
    @error_code = -2030
  end

end
