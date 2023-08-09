ActiveAdmin.register Customer do
  menu priority: 1

  permit_params :email, :user_id, :order_id, :gst, :pst, :hst, :total_with_taxes, :product_data

  index do
    selectable_column
    id_column
    column :email
    column :user_id
    column :order_id
    column :gst
    column :pst
    column :hst
    column :total_with_taxes
    column :product_data
    actions
  end

  filter :email
  filter :user_id
  filter :order_id
  filter :gst
  filter :pst
  filter :hst
  filter :total_with_taxes

  show do
    attributes_table do
      row :email
      row :user_id
      row :order_id
      row :gst
      row :pst
      row :hst
      row :total_with_taxes
      row :product_data
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :user_id
      f.input :order_id
      f.input :gst
      f.input :pst
      f.input :hst
      f.input :total_with_taxes
      f.input :product_data
    end
    f.actions
  end
end
