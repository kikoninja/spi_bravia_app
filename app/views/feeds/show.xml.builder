xml.instruct!
xml.trebuchet(:version => "2.0") do
  xml.mehta_data_version 1
  if @feed.title == "branch"
    xml << render( :partial => 'branch', :locals => { :channel => @channel })
  else
    xml << render( :partial => 'leaf', :locals => { :feed => @feed, :channel => @channel })
  end
end

