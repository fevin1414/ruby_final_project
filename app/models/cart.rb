# cart.rb
class Cart
  attr_reader :items

  def initialize(session)
    @session = session
    @session[:cart] ||= {}
    @items = @session[:cart]
  end

  def add_item(product_id, quantity = 1)
    product_id = product_id.to_s
    if @items[product_id]
      @items[product_id] += quantity
    else
      @items[product_id] = quantity
    end
  end

  def remove_item(product_id)
    @items.delete(product_id.to_s)
  end

  def update_item(product_id, quantity)
    @items[product_id.to_s] = quantity
  end

  def total
    @items.sum { |product_id, quantity| product_total(Product.find_by(id: product_id), quantity) }
  end

  private

  def product_total(product, quantity)
    return 0 unless product

    product.price * BigDecimal(quantity)
  end

  def clear
    @session[:cart] = {}
    @items = @session[:cart]
  end
end
