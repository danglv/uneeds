class AddKindToTransfer < ActiveRecord::Migration[5.1]
  def change
    add_column :transfers, :kind, :integer, default: 0
  end
end
