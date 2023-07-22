
ActiveAdmin.register Review do
  permit_params :customer_name, :rating, :content, :product_id, images: []
  filter :product
  filter :customer_name
  filter :rating
  filter :content, as: :string, filters: ['custom_eq']
  # You can add more filters for other attributes if needed

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
