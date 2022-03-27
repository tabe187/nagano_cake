class Public::CartItemsController < ApplicationController
  def index
   @cart_items = current_customer.cart_items
  end

  def create
   @cart_item = CartItem.new(cart_item_params)
   @cart_item.customer_id = current_customer.id
   @item = current_customer.cart_items.find_by(item_id: @cart_item.item_id)
    if @item
       new_amount = @cart_item.amount.to_i + @item.amount.to_i
       @item.update(amount: new_amount)
    else
       @cart_item.save
    end
   redirect_to cart_items_path
  end

  def update
   @cart_item = CartItem.find(params[:id])
   @cart_item.update(cart_item_params)
   redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end
