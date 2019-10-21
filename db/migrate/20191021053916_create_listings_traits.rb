class CreateListingsTraits < ActiveRecord::Migration[5.2]
  def change
    create_table :listings_traits do |t|
      t.references :listing, foreign_key: true
      t.references :trait, foreign_key: true

      t.timestamps
    end
  end
end
