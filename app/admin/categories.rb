ActiveAdmin.register Category do

  form do |f|
    f.inputs do
      f.input :channel_id, :label => "Chanel", :as => :select, :collection => Channel.order('id ASC')
      f.input :title
      f.input :description
      f.input :style, :as => :select, :collection => Category::STYLES, :include_blank => false
      f.input :order
      f.input :icon, :as => :file
      f.input :parent_id, :label => "Parent", :as => :select, :collection => Category.order('id ASC')
    end
    f.buttons
  end

end
