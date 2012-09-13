ActiveAdmin.register_page "Dashboard" do

end

# ActiveAdmin::Dashboards.build do
# 
#   section "Refresh recent feeds" do
#     div do
#       render 'refresh_links', :service_name => "PL-FilmBoxLive", :feed_ids => { "Branch" => "6479", "Leaf1" => "6481", "Leaf2" => "6483", "Leaf3" => "6485"}, :secret_key => "iethohSei3chu", :baseurl => "http://dev.internet.sony.tv/trebuchet/remoteCommands/TREBpushImport/"
#     end
#   end
# 
#   # Define your dashboard sections here. Each block will be
#   # rendered on the dashboard in the context of the view. So just
#   # return the content which you would like to display.
# 
#   # == Simple Dashboard Section
#   # Here is an example of a simple dashboard section
#   #
#   #   section "Recent Posts" do
#   #     ul do
#   #       Post.recent(5).collect do |post|
#   #         li link_to(post.title, admin_post_path(post))
#   #       end
#   #     end
#   #   end
# 
#   # == Render Partial Section
#   # The block is rendered within the context of the view, so you can
#   # easily render a partial rather than build content in ruby.
#   #
#   #   section "Recent Posts" do
#   #     div do
#   #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
#   #     end
#   #   end
# 
#   # == Section Ordering
#   # The dashboard sections are ordered by a given priority from top left to
#   # bottom right. The default priority is 10. By giving a section numerically lower
#   # priority it will be sorted higher. For example:
#   #
#   #   section "Recent Posts", :priority => 10
#   #   section "Recent User", :priority => 1
#   #
#   # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.
# 
#   # == Conditionally Display
#   # Provide a method name or Proc object to conditionally render a section at run time.
#   #
#   # section "Membership Summary", :if => :memberships_enabled?
#   # section "Membership Summary", :if => Proc.new { current_admin_user.account.memberships.any? }
# 
# end
