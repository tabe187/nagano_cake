class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(order_detail_params)
    @maiking_status = OrderDetail.find_by(making_status: "in_production")
    @maiking_statuses = OrderDetail.where(making_status: "production_complete").count
    @order_details = OrderDetail.where(order_id: @order_detail.order_id).count
     if @maiking_statuses.to_i == @order_details.to_i
        @order.update(status: "preparing_delivery")
        redirect_to admin_order_path(@order.id)
     elsif @maiking_status
        @order.update(status: "in_production")
        redirect_to admin_order_path(@order.id)
     else
        redirect_to admin_order_path(@order.id)
     end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :amount, :making_status)
  end


end
