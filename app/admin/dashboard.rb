ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    panel "All Users" do
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
  end
end