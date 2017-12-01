class CreateSalesmen < ActiveRecord::Migration[5.0]
  def change
    create_table :salesmen do |t|
      t.string :name
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
