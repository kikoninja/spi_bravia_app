xml.instruct!
xml.response do
  xml.header(version: '01') do
    xml.command "STSgetAuthorization"
    xml.code @result_code
  end

  xml.sony do
    xml.product(id: "CALLISTO") do
      xml << render( partial: @result) 
    end
  end
end
