xml.instruct!
xml.response do
  xml.header(version: '01') do
    xml.command "SSMgetUserData"
    xml.code 0
  end

  xml.sony do
    xml.product(id: "CALLISTO") do
      xml.user_token "nil"
      xml.suit "nil"
    end
  end
end
