xml.instruct!
xml.response do
  xml.header(version: '01') do
    xml.command "SSMgetUserData"
    xml.code @result_code
  end

  xml.sony do
    xml.product(id: "CALLISTO") do
      xml.user_token "nil"
      xml.suit "nil"
    end
  end
end
