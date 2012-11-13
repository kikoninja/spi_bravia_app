require 'spec_helper'

describe ApplicationHelper do

  it "calculates sig from parameters" do
    base_url = "https://spibivl.invideous.com/bivldev/sts_get_authorization/STSgetAuthorization/?"
    parameters = { id: "13-asset-1653298", language: "en", service_name: "PL-FilmBoxLive_Prod", provider: "FilmBoxLive_Prod", ip_address: "174.46.232.2", suit: "31177ea755138133f699bbd6b7319ed3", esn: "SONY-DTV12-544249B5261D", type: "asset", reg_status: "true", ui_type: "0", request_timestamp: "2012-11-13T00%3A09%3A27%2B00%3A00" }

    result_sig = calculate_signature(parameters)

    result_sig.should == "6a0774b88dee5df1bb1ea5e14de1f7e1"
  end

end
