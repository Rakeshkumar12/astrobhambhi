ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  ActiveAdmin.register Service do
    controller do
    def permitted_params
      params.permit service: [:title, :description, :amount, :currency_symbol,:image]
    end
    end

     form :html => { :enctype => "multipart/form-data" } do |f|
       f.inputs "Details" do
        f.input :title
        f.input :description
        f.input :amount
        f.input :currency_symbol, :label => 'Currency', :as => :select, :collection => [['USD','usd'],["$","$"],["€","€"]]
        f.input :image, :as => :file
      end
      f.actions
  end
end

end
