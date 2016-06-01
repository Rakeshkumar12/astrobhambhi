class AddAmountFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :amount, :integer
    add_column :users, :dob_time, :string
  end
end
