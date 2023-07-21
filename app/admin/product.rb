ActiveAdmin.register Product do
  permit_params :category_id, :stock, :name, :description, :price, :image_id

  form do |f|
    f.inputs "Product Details" do
      f.input :category, as: :select, collection: Category.all.map { |c| [c.name, c.id] }
      f.input :stock
      f.input :name
      f.input :description, as: :text
      f.input :price

    end
    f.actions
  end
end