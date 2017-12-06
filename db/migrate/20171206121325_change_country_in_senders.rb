class ChangeCountryInSenders < ActiveRecord::Migration[5.1]
  def up
    change_column :senders, :country, "integer USING country::integer"
  end

  def down
    change_column :senders, :country, :string
  end
end
