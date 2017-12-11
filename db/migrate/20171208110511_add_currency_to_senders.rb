class AddCurrencyToSenders < ActiveRecord::Migration[5.1]
  def change
    add_column :senders, :currency, :integer
  end
end
