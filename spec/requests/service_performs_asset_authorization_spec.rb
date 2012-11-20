require 'authorizer'
require 'date'

describe "Service performs asset authorization" do

  let(:signature) { "44a38b627055c60d798bff1ec6b47e1c" }
  let(:user) { stub(username: "User name") }
  let(:affiliated_user) { stub(user: user) }
  let(:parameters) { { id: "hls-asset-04", language: "en", service_name: "Service Name", suit: "7ffabe402b3aa0c27354b80c1ebb698d", provider: "Provider", ip_address: "174.46.232.12", esn: "SONY ESN", type: "asset", reg_status: "true", ui_type: "0", request_timestamp: DateTime.now.to_s, sig: "44a38b627055c60d798bff1ec6b47e1c" } }

  before(:each) do
    affiliated_user.stub(:suit).and_return("7ffabe402b3aa0c27354b80c1ebb698d")
  end

  it "authorizers user for all conditions completed" do
    # When
    authorizer = Authorizer.new(signature, parameters)
    authorizer.authorize

    # Then
    authorizer.error_code.should == 0
  end
# 
  it "denies the asset access to user for missing service name parameter" do
    parameters.delete(:service_name)
    parameters[:sig] = "INVALID"

    # When
    authorizer = Authorizer.new(signature, parameters)
    authorizer.authorize

    # Then
    authorizer.error_code.should == 40
  end

  # it "denies the asset access to user for unknown user suit" do
  #   # Given
  #   parameters[:suit] = "INVALID"

  #   # When
  #   authorizer = Authorizer.new(signature, parameters)
  #   authorizer.authorize

  #   # Then
  #   authorizer.error_code == -2027
  # end

  it "denies the asset access to user for invalid signature" do
    # Given
    parameters[:sig] = "INVALID"
    
    # When
    authorizer = Authorizer.new(signature, parameters)
    authorizer.authorize

    # Then
    authorizer.error_code.should == -2002
  end

  it "denies the asset access to user for invalid request timestamp" do
    # Given
    parameters[:request_timestamp] = (DateTime.now - 5).to_s

    # When
    authorizer = Authorizer.new(signature, parameters)
    authorizer.authorize

    # Then
    authorizer.error_code.should == -2030
  end

end
