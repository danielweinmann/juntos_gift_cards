class CreateGiftCards < ActiveRecord::Migration
  def change
    create_table :gift_cards do |t|
      t.references :user
      t.string :code
      t.integer :value
      t.string :state
      t.timestamps
    end
    add_index :gift_cards, :state
  end
end
