require 'signature_calculator'

describe SignatureCalculator do

  context "#calculate_sig" do
    let(:correct_sig) { "6a445592e3ef03240bac7d1c56d509bd" }
    let(:correct_url) { "https://spibivl.invideous.com/bivldev/sts_get_authorization/STSgetAuthorization?id=12-asset-5526393&language=en&service_name=PL-FilmBoxLive_Prod&provider=FilmBoxLive_Prod&ip_address=174.46.232.12&suit=04a0af20e1695e0f7d41c4849f72be45&esn=SONY-TV12A-B00000F98231&type=asset&reg_status=true&ui_type=0&request_timestamp=2012-11-19T23%3A55%3A07%2B00%3A00&sig=6a445592e3ef03240bac7d1c56d509bd" }
    let(:wrong_url) { " https://spibivl.invideous.com/bivldev/sts_get_authorization/STSgetAuthorization?id=15-asset-5526367&language=en&service_name=PL-FilmBoxLive_Prod&provider=FilmBoxLive_Prod&ip_address=174.46.232.12&suit=04a0af20e1695e0f7d41c4849f72be45&esn=SONY-TV12A-B00000F98231&type=asset&reg_status=true&ui_type=0&request_timestamp=2012-11-19T23%3A54%3A27%2B00%3A0&sig=sig=d8167e20eb3f60f8c86a7a15f3d5545f0" }
    let(:inbound_key) { "wa1Kev6guokaiduu4iec" }

    it "returns correct signature for given correct url and inbound token" do
      sig_calculator = SignatureCalculator.new(correct_url, inbound_key)  
      sig_calculator.calculate_sig.should == correct_sig
    end

    it "returns wrong signature for given wrong url and inbound token" do
      sig_calculator = SignatureCalculator.new(wrong_url, inbound_key)
      sig_calculator.calculate_sig.should_not == correct_sig
    end
  end

end
