class CreateTransfers < ActiveRecord::Migration[5.1]
  def change
    create_table :transfers do |t|
      t.string     :status
      t.json       :sender_data
      t.json       :recipient_data
      t.references :sender
      t.references :recipient
      t.references :payment
      t.references :user

      t.timestamps null: false
    end
  end
end
