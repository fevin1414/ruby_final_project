# cart.rb
class Cart
  attr_reader :items, :user

  def initialize(session, user)
    @session = session
    @user = user
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

    save_to_database
  end

  def remove_item(product_id)
    product_id = product_id.to_s
    @items.delete(product_id)
    save_to_database
  end

  def update_item(product_id, quantity)
    product_id = product_id.to_s
    @items[product_id] = quantity.to_i
    save_to_database
  end

  def total
    @items.sum { |product_id, quantity| product_total(Product.find_by(id: product_id), quantity) }
  end

  private

  def product_total(product, quantity)
    return 0 unless product

    product.price * BigDecimal(quantity)
  end

  private

  def save_to_database
    return unless @user

    shopping_cart = @user.shopping_cart || ShoppingCart.find_or_initialize_by(user: @user)
    shopping_cart.total_price = total

    shopping_cart.transaction do
      shopping_cart.save!

      shopping_cart.cart_items.destroy_all

      @items.each do |product_id, quantity|
        product = Product.find_by(id: product_id)
        if product
          cart_item = shopping_cart.cart_items.build(product: product, quantity: quantity)
          cart_item.cart_id = shopping_cart.id  # Set the cart_id here
          cart_item.save!
        end
      end
    end

    clear unless @user
  end

  def clear
    if @user
      @session[:cart] = {}
      @items = @session[:cart]
    else
      @session.delete(:cart)
      @items = {}
    end
  end
end
