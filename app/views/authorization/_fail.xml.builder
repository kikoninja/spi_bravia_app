xml.authorization(result: "fail", ) do
  xml.form do
    xml.background do
      xml.message("Code: ", left: "50", right: "150", top: "250", bottom: "340")
      xml.input(name: "code", title: "Code")
    end
  end
end
