ActiveAdmin.register AboutPage do
  permit_params :content

  form do |f|
    f.inputs "About Page Content" do
      f.input :content, label: "Tell us about your agricultural product manufacturer:", as: :text
    end
    f.actions
  end
end
