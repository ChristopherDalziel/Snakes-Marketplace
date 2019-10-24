class ChangeListing < ActiveRecord::Migration[5.2]
  def change
    change_column :listings, :deposit, :integer, null: false, default: 1
  end
end
