class CreateSenders < ActiveRecord::Migration[5.1]
  def change
    create_table :senders do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :birthday
      t.string :phone
      t.string :country
      t.string :address
      t.string :city
      t.string :post_code
      t.string :first_name_katakana
      t.string :last_name_katakana
      t.string :occupation
      t.references :user

      t.timestamps null: false
    end
  end
end
