ActiveAdmin.register Product do
  permit_params :category_id, :stock, :name, :description, :price, :image

  show do
    attributes_table do
      row :id
      row :category
      row :stock
      row :name
      row :description
      row :price
      row :image do |product|
        image_tag product.image.url if product.image.present?
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Product Details" do
      f.input :category, as: :select, collection: Category.all.map { |c| [c.name, c.id] }
      f.input :stock
      f.input :name
      f.input :description, as: :text
      f.input :price
      f.input :image, as: :file # This allows you to upload an image for the product
    end
    f.actions
  end
end