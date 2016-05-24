class OrdersController < ApplicationController
  before_action :authenticate_user!
  def new
  	@order =  Order.new
  end

  def create
	  @order = current_user.orders.build(order_params)
	  @order.ip_address = request.remote_ip
	  if @order.save
	    if @order.purchase(params[:amount])
	      render :action => "success"
	    else
	      render :action => "failure"
	    end
	  else
	    render :action => 'new'
	  end
  end

  private
    def order_params
    	params.require(:order).permit(:first_name,:last_name,:card_type,:card_number,:card_verification,:card_expires_on)
    end
end
