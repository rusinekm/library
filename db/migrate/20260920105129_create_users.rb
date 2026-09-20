class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :full_name,  null: false
      t.string :email, null: false
      t.integer :library_card, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :library_card, unique: true
  end
end
