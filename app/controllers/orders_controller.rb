class OrdersController < ApplicationController
  before_action :authenticate_user!
  #before_action :auth_user
  before_action :user_authenticate, only: :new
  def new
    @order =  Order.new
  end

  def edit
    @order = current_user
  end

  def update
    @title = params[:title]
    @order = User.find(params[:id])
    @order.update_attributes(user_params)
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
    if params[:query] == 'ccavenue'
      amount = @user.amount.to_s
      merchantData=""
      working_key= ENV["ccavenue_key"]
      @access_code= ENV["ccavenue_access_code"]
      params = {"merchant_id"=>ENV["ccavenue_merchant_id"], "order_id"=>@user.id.to_s, "amount"=>amount, "currency"=>@user.currency, "redirect_url"=>"http://localhost:3000/", "cancel_url"=>"http://localhost:3000/", "language"=>"EN", "billing_name"=>"Charli", "billing_address"=>"Room no 1101, near Railway station Ambad", "billing_city"=>"Indore", "billing_state"=>"MP", "billing_zip"=>"425001", "billing_country"=>"India", "billing_tel"=>"9876543210", "billing_email"=>"person@gmail.com", "delivery_name"=>"Chaplin", "delivery_address"=>"room no.701 near bus stand", "delivery_city"=>"Hyderabad", "delivery_state"=>"Andhra", "delivery_zip"=>"425001", "delivery_country"=>"India", "delivery_tel"=>"9595226054", "merchant_param1"=>"additional Info.", "merchant_param2"=>"additional Info.", "merchant_param3"=>"additional Info.", "merchant_param4"=>"additional Info.", "merchant_param5"=>"additional Info.", "promo_code"=>"", "customer_identifier"=>""}
      params.each do |key,value|
        merchantData += key+"="+value+"&" 
      end
      crypto = Crypto.new
      @encrypted_data = crypto.encrypt(merchantData,working_key)
    else
      redirect_to @user.paypal_url(registration_path(@user))
    end
  end

  def ccavResponseHandler
  end

  def auth_user
    redirect_to new_user_registration_url unless user_signed_in?
  end

  def user_authenticate
    redirect_to root_path if user_signed_in?
  end

  private
    
    def user_params
      params.require(:user).permit(:email,:name, :phone, :sex, :dob, :place, :father_huband_name, :address, :subject, :description, :question,:amount,:currency,:dob_time)
    end

    def order_params
      params.require(:order).permit(:first_name,:last_name,:card_type,:card_number,:card_verification,:card_expires_on,:amount)
    end
end
