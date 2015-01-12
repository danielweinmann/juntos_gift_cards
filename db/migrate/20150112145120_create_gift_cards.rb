class CreateGiftCards < ActiveRecord::Migration
  def change
    create_table :gift_cards do |t|
      t.references :user, null: false
      t.string :code, null: false
      t.integer :value, null: false
      t.string :state
      t.timestamps
    end
    add_index :gift_cards, :code, unique: true
    add_index :gift_cards, :state
  end
end
