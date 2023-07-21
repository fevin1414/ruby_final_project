ActiveAdmin.register ContactPage do
  permit_params :content

  form do |f|
    f.inputs "Contact Page Content" do
      f.input :content, label: "Contact Information:", input_html: { as: :text }
    end
    f.actions
  end
end