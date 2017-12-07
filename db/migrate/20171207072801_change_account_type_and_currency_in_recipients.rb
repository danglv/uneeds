class ChangeAccountTypeAndCurrencyInRecipients < ActiveRecord::Migration[5.1]
  def up
    change_column :recipients, :account_type, "integer USING account_type::integer"
    change_column :recipients, :currency, "integer USING currency::integer"
  end

  def down
    change_column :recipients, :account_type, :string
    change_column :recipients, :currency, :string
  end
end
