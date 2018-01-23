class CreateHighTransfers < ActiveRecord::Migration[5.1]
  def change
    create_table :high_transfers do |t|
      t.references :user
      t.float :amount
      t.float :guaranteed_rate
      t.integer :currency

      t.timestamps
    end
  end
end
