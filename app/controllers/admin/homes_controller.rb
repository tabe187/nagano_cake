class Admin::HomesController < ApplicationController
  def top
    @orders = Order.page(params[:page])
  end
  
  private

  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :postal_code, :address, :name, :shipping_cost, :billing_amount, :status)
  end

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :amount, :making_status)
  end
  
end
