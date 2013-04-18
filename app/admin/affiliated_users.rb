ActiveAdmin.register AffiliatedUser do

  form do |f|
    f.inputs do
      f.input :id
      f.input :username
      f.input :suit
      f.input :created_at, :label => "Created at"
      f.input :updated_at, :label => "Updated at"
    end
    f.buttons
  end

end