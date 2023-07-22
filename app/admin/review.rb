ActiveAdmin.register Review do
  permit_params :customer_name, :rating, :content, :product_id, images: []

  form do |f|
    f.inputs 'Review Details' do
      f.input :product
      f.input :customer_name
      f.input :rating
      f.input :content
      f.input :images, as: :file, input_html: { multiple: true, accept: 'image/*' }
    end
    f.actions
  end
end