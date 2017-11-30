class AddFieldToPayment < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :transfer_amount, :float
    add_column :payments, :fee, :float
  end
end
