class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :city
      t.string :state
      t.string :country
      t.string :password_digest
      t.integer :contact_num

      t.timestamps
    end
  end
end
