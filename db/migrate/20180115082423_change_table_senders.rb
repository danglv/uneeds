class ChangeTableSenders < ActiveRecord::Migration[5.1]
  def change
    remove_column :senders, :first_name
    remove_column :senders, :last_name
    remove_column :senders, :birthday
    remove_column :senders, :country
    remove_column :senders, :address
    remove_column :senders, :city
    remove_column :senders, :post_code
    remove_column :senders, :first_name_katakana
    remove_column :senders, :last_name_katakana
    remove_column :senders, :occupation

    add_column    :senders, :name, :string
    add_column    :senders, :name_katakana, :string
    add_column    :senders, :wechat_id, :string

    remove_column :recipients, :ibank
  end
end
