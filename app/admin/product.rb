ActiveAdmin.register Product do
  permit_params :category_id, :stock, :name, :description, :price, images: []



  form do |f|
    f.inputs do
      f.input :category
      f.input :stock
      f.input :name
      f.input :description, as: :text
      f.input :price

      if f.object.images.present?
        f.input :images, as: :file, input_html: { multiple: true, accept: "image/*" }, hint: "Current Images: #{f.object.images.count}"
      else
        f.input :images, as: :file, input_html: { multiple: true, accept: "image/*" }, hint: "No Images Available"
      end
    end
    f.actions
  end
end
