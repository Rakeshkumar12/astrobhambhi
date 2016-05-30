class OrdersController < ApplicationController
  before_action :auth_user
  before_action :user_authenticate, only: :new
  def new
  	@order =  Order.new
  end

  def edit
  	@order = current_user
  end

  def update
  	@registration = User.find(params[:id])
    @registration.update_attributes(user_params)
    #   redirect_to @registration.paypal_url(registration_path(@registration))
    # else
    #   render :new
    # end
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

  def show
  	@user = User.find(params[:id])
    redirect_to @user.paypal_url(registration_path(@user))
  end

  def auth_user
    redirect_to new_user_registration_url unless user_signed_in?
  end

  def user_authenticate
  	redirect_to home_index_path if user_signed_in?
  end

  private
    
    def user_params
    	params.require(:user).permit(:email,:name, :phone, :sex, :dob, :place, :father_huband_name, :address, :subject, :description, :question,:amount)
    end

    def order_params
    	params.require(:order).permit(:first_name,:last_name,:card_type,:card_number,:card_verification,:card_expires_on,:amount)
    end
end
