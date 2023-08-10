ActiveAdmin.register Customer do
  index do

    column :email
    column :total_with_taxes
    column "Orders" do |customer|
      customer.orders.map do |order|
        link_to order.id, admin_order_path(order)
      end.join(", ").html_safe
    end
    # ... other columns ...
  end
end
