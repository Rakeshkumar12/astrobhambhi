class OrdersController < ApplicationController
	before_action :authenticate_user!
  #before_action :auth_user
  before_action :user_authenticate, only: :new
  def new
  	@order =  Order.new
  end

  def edit
  	@order = current_user
  	#@CCAVENUE_MERCHANT_ID = "bhambi3351"
    #order_id =  Time.now.strftime('%d%m%H%L') + @registration.id
    #@encRequest = ccavenue.request(12345,200,"test","delhi","bgfhdg","noida",201301,"up","india","nagendra@gmail.com",1234556)
  end

  def update
    @title = params[:title]
  	@order = User.find(params[:id])
    @order.update_attributes(user_params)
    #@CCAVENUE_MERCHANT_ID = "bhambi3351"
    #order_id =  Time.now.strftime('%d%m%H%L') + @registration.id
    #@encRequest = ccavenue.request(12345,200,@registration.name,"#{@registration.address}","bgfhdg","noida",201301,"up","india","nagendra@gmail.com",1234556)
    #   redirect_to @registration.paypal_url(registration_path(@registration))
    # else
    #render :ccavenue_form
    # end
  end

#   def send_to_ccavenue


#     # Merchant id needed in view
#     @CCAVENUE_MERCHANT_ID = <TODO: MERCHANT ID>

#     # CCAvenue requires a new order id for each request 
#     # so if transaction fails we can use #same ones again accross our website.
#     order_id =  Time.now.strftime('%d%m%H%L') + <TODO: Order Id>

#     # Parameters:
#     #
#     #   order_id
#     #   price
#     #   billing_name
#     #   billing_address
#     #   billing_city
#     #   billing_zip
#     #   billing_state
#     #   billing_country
#     #   billing_email
#     #   billing_phone
#     #   billing_notes
#     #   delivery_name
#     #   delivery_address
#     #   delivery_city
#     #   delivery_zip
#     #   delivery_state
#     #   delivery_country
#     #   delivery_email
#     #   delivery_phone
#     #   delivery_notes
#     #
#     #
#     #   Mandatory - order_id,price,billing_name,billing_address,billing_city,billing_zip,billing_state,billing_country,billing_email,billing_phone
#     #   Optional - billing_notes,delivery_name,delivery_address,delivery_city,delivery_zip,delivery_state,delivery_country,delivery_email,delivery_phone,delivery_notes

#     # Creating encrypted data
#     @encRequest = ccavenue.request(order_id,<TODO: Price>,@order.full_name,"#{@order.address1} ,#{@order.address2}",@order.city,@order.zip,@order.state,@order.country,@order.email,@order.phone)

#     render "<TODO: Redirect Page>"
# end

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
    	params.require(:user).permit(:email,:name, :phone, :sex, :dob, :place, :father_huband_name, :address, :subject, :description, :question,:amount,:currency,:dob_time)
    end

    def order_params
    	params.require(:order).permit(:first_name,:last_name,:card_type,:card_number,:card_verification,:card_expires_on,:amount)
    end
end
