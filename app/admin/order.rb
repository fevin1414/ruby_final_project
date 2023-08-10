ActiveAdmin.register Order do
  index do
    column :total
    column :created_at
    column :status
    column :payment_id
    column "Customer" do |order|
      link_to order.user.customer.email, admin_customer_path(order.user.customer)
    end
    # ... other columns
  end
end
