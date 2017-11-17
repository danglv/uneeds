class CreateExchanges < ActiveRecord::Migration[5.1]
  def change
    create_table :exchanges do |t|
      t.integer :currency_from_id
      t.integer :currency_to_id
      t.float   :guaranteed_rate

      t.timestamps null: false
    end
  end
end
