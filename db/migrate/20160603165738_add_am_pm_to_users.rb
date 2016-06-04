class AddAmPmToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dob_am_pm, :string
  end
end
