class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  #validates :name, presence: true
  has_many :orders

  def paypal_url(return_path)
    values = {
        business: "nakshatra@astrobhambi.com",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: 1,
        amount: self.amount,
        item_name: self.subject,
        item_number: self.id,
        quantity: 1
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
end
