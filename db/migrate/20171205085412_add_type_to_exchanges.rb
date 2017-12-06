class AddTypeToExchanges < ActiveRecord::Migration[5.1]
  def change
    add_column :exchanges, :type, :string
    add_column :exchanges, :jp_name, :string
    add_column :exchanges, :cn_name, :string
    add_column :exchanges, :code, :string
  end
end
