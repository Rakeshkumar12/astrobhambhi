class AddCurrencyFiledToServices < ActiveRecord::Migration
  def change
    add_column :services, :currency_symbol, :string
  end
end
