ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock, :category_id, :on_sale,
                :newly_added, :recently_updated, product_images_attributes: [:id, :image, :_destroy]

  form do |f|
    f.inputs 'Product Details' do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock
      f.input :category
      f.input :on_sale, label: 'On Sale'
      f.input :newly_added, label: 'Newly Added'
      f.input :recently_updated, label: 'Recently Updated'
      f.has_many :product_images, allow_destroy: true do |image|
        image.input :image, as: :file, input_html: { accept: 'image/*' }
      end
    end
    f.actions
  end

  show do
    h1 product.name
    p "Description: #{product.description}"
    p "Price: #{product.price}"
    p "Available Stock: #{product.stock}"

    attributes_table do
      row :name
      row :description
      row :price
      row :stock
      row :category
      row :on_sale
      row :newly_added
      row :recently_updated
      row :created_at
      row :updated_at
    end

    panel 'Main Image' do
      # Display the thumbnail as the main image
      if product.product_images.any?
        image_tag product.product_images.first.image.url(:thumbnail)
      else
        # Replace 'placeholder_image_url' with the placeholder image URL if no images are present
        image_tag 'https://lorempixel.com/200/200/', class: 'placeholder-image'
      end
    end

    panel 'Product Images' do
      table_for product.product_images.drop(1) do
        column :image do |img|
          image_tag img.image.url(:thumbnail)
        end
      end
      # Display a placeholder image for the product images section if no additional images are present
      image_tag 'https://lorempixel.com/200/200/', class: 'placeholder-image' unless product.product_images.drop(1).any?
    end

    panel 'Reviews' do
      table_for product.reviews do
        column :customer_name
        column :rating
        column :review
        column :created_at
        column :images do |review|
          review.images.each do |image|
            span do
              image_tag image.variant(resize: '100x100')
            end
          end
        end
      end
    end
  end
end
