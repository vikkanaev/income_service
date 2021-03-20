class CreatePeriods < ActiveRecord::Migration[6.0]
  def change
    create_table :periods do |t|
      t.date :date
      t.references :user, null: false, foreign_key: true
      t.monetize :amount_total

      t.timestamps
    end
    add_index :periods, :date
  end
end
