xml.authorization(result: "fail") do
  xml.form(title: 'Important') do
    xml.message @message
  end
end
