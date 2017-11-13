class CreateRecipients < ActiveRecord::Migration[5.1]
  def change
    create_table :recipients do |t|
      t.string :email
      t.string :full_name
      t.string :ibank
      t.string :currency
      t.string :type
      t.string :bank_name
      t.string :branch_name
      t.string :account_number
      t.string :account_type
      t.references :user

      t.timestamps null: false
    end
  end
end
