# app/admin/dashboard.rb

ActiveAdmin.register_page "Dashboard" do
  # Customize the main menu
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  # Define the content of the dashboard
  content title: proc { I18n.t("active_admin.dashboard") } do
    # Define a section in the dashboard
    section "All Users" do
      # Create a table with the user data
      table_for User.order("created_at desc") do
        column :email
        column :current_sign_in_at
        column :sign_in_count
        column :created_at
        column :roles do |user|
          user.roles.map(&:name).join(', ') if user.is_a?(AdminUser)
        end
      end
    end

    # Add more sections or custom content as needed
  end
end
