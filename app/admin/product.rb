ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock, :category_id, :on_sale,
                :newly_added, :recently_updated, product_images_attributes: [:id, :image, :_destroy]

                controller do
                  def update
                    # Ensure the permitted attributes are updated in the model
                    super do |format|
                      redirect_to collection_path and return if resource.valid?
                    end
                  end
                end

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

    panel 'Images' do
      table_for product.product_images do
        column :thumbnail do |img|
          image_tag img.image.url(:thumbnail)
        end
        column :left_image do |img|
          image_tag img.image.url(:left_image)
        end
        column :back_image do |img|
          image_tag img.image.url(:back_image)
        end
        column :side_image do |img|
          image_tag img.image.url(:side_image)
        end
      end
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