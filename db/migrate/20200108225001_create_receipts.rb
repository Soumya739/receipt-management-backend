class CreateReceipts < ActiveRecord::Migration[6.0]
  def change
    create_table :receipts do |t|
      t.string :store
      t.float :total_amount
      t.date :generated_on
      t.integer :user_id
      t.string :expense_type, array: true

      t.timestamps
    end
    add_index :receipts, :expense_type, using: 'gin'
  end
end
