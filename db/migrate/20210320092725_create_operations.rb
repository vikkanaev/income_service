class CreateOperations < ActiveRecord::Migration[6.0]
  def change
    create_table :operations do |t|
      t.monetize :amount
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.references :period, null: false, foreign_key: true

      t.timestamps
    end
  end
end
