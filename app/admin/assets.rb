ActiveAdmin.register Asset do

  form do |f|
    f.inputs do
      f.input :feed_id, :label => "Feed", :as => :select, :collection => Feed.order('id ASC')
      f.input :video_id, :label => "Video", :as => :select, :collection => Video.order('id ASC')
      f.input :title
      f.input :description
      f.input :pay_content, :as => :boolean
      f.input :asset_type, :label => "Asset Type", :as => :select, :collection => Asset::TYPES
      f.input :categories, :label => "Category", :as => :check_boxes, :collection => Category.roots
    end
    f.buttons
  end

end
