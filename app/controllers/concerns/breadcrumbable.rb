module Breadcrumbable
  extend ActiveSupport::Concern

  included do
    before_action :init_breadcrumbs
    before_action -> { set_breadcrumbs }
  end

  def init_breadcrumbs
    @breadcrumbs ||= []
  end

  def set_breadcrumbs
    case controller_name
    when 'carts'
      add_breadcrumb 'Products', products_path
      if @product.present?
        add_breadcrumb @product.name, product_path(@product)
      end
      add_breadcrumb 'Cart', cart_path
    when 'products'
      add_breadcrumb 'Products', products_path
      if action_name == 'show' && @product.present?
        add_breadcrumb @product.name, product_path(@product)
      end
    end
  end

  def breadcrumbs
    return [] if @breadcrumbs.nil?
    @breadcrumbs.unshift({ name: 'Home', url: root_path })
  end

  def add_breadcrumb(name, url)
    @breadcrumbs << { name: name, url: url }
  end
end
