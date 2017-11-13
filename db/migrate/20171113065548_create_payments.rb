class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.float   :guaranteed_rate
      t.float   :amount
      t.references :exchange

      t.timestamps null: false
    end
  end
end
