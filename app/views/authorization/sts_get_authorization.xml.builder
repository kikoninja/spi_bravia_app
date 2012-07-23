xml.instruct!
xml.response do
  xml.header(version: '01') do
    xml.command "STSgetAuthorization"
    xml.code 0
  end

  xml.sony do
    xml.product(id: "CALLISTO") do
      xml << render( partial: "success")
    end
  end
end
