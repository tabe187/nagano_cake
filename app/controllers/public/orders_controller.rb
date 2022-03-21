class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
    @addresses = Address.all
    @address = Address.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.price = cart_item.item.price
      @order_detail.amount = cart_item.amount
      @order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_thanks_path
  end

  def confirm
    @cart_items = CartItem.all
    @order = Order.new(order_params)
      if params[:order][:select_address] == "0"
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
        @order.name =  current_customer.last_name + current_customer.first_name
      elsif params[:order][:select_address] == "1"
        @address = Address.find(params[:order][:address_id])
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.name = @address.name
      else
        render :confirm
      end
  end

  def thanks
  end

  def index
    @orders = Order.all
    @order_details = OrderDetail.all
  end

  def show
    @orders = Order.find(params[:id])
    @order_details = OrderDetail.all
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :postal_code, :address, :name, :shipping_cost, :billing_amount, :status)
  end

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :amount, :making_status)
  end

end



