ActiveAdmin.register Order do
  permit_params :total, :user_id, :status, :payment_id

  index do
    selectable_column
    id_column
    column :total
    column :user do |order|
      order.user.name.present? ? order.user.name : order.user.email
    end
    column :status
    column :payment_id
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :total
      row :user do |order|
        order.user.name.present? ? order.user.name : order.user.email
      end
      row :status
      row :payment_id
      row :created_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :total

      f.input :status, as: :select, collection: ["new", "paid", "processed", "shipped", "completed"]
      f.input :payment_id
    end
    f.actions
  end

  filter :total
  filter :user
  filter :status
  filter :created_at
end
