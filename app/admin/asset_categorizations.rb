ActiveAdmin.register AssetCategorization do

  form do |f|
    f.inputs do
      f.input :asset_id, :label => "Asset", :as => :select, :collection => Asset.order('id ASC')
      f.input :category_id, :label => "Category", :as => :select, :collection => Category.roots
    end
    f.buttons
  end

end
