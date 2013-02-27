xml.authorization(result: "invalid_subscription") do
  xml.form(title: 'Important') do
    xml.message "You do not have a valid subscrption."
  end
end
