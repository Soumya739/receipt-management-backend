class CreateReceiptExpenseTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :receipt_expense_types do |t|
      t.integer :receipt_id
      t.integer :expense_type_id

      t.timestamps
    end
  end
end
