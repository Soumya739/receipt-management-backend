class CreateReceipts < ActiveRecord::Migration[6.0]
  def change
    create_table :receipts do |t|
      t.string :image_url
      t.string :store
      t.float :total_amount
      t.date :generated_on
      t.integer :user_id

      t.timestamps
    end
  end
end
