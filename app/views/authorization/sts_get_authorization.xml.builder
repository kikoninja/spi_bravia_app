xml.instruct!
xml.response do
  xml.header(version: '01') do
    xml.command "STSgetAuthorization"
    xml.code 0
  end

  xml.sony do
    xml.product(id: "FilmBox") do
      xml.authorization(result: "success") do
        xml.asset(id: @asset_id) do
          xml.speed_check do
            xml.source(url: "http://")
          end
        end
      end
    end
  end
end
