class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # def ccavenue
  #   return @ccavenue = Ccavenue::Payment.new(<TODO: MERCHANT ID>,<TODO: MERCHANT WORKING KEY>,<TODO: REDIRECT URL>)
  # end
  protected

  def configure_permitted_parameters
    #devise_parameter_sanitizer.for(:sign_up).push(:name, :phone, :sex, :dob, :place, :father_huband_name, :address, :subject, :description, :question)
    devise_parameter_sanitizer.for(:sign_up) << [:name, :phone, :sex, :dob, :place, :father_huband_name, :address, :subject, :description, :question]
  end
end