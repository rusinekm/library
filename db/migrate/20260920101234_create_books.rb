class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.references :author, null: false
      t.integer :serial_number, null: false
      t.string :title, null: false
      t.boolean :deleted, default: false, null: false

      t.timestamps
    end

    add_index :books, :serial_number, unique: true
  end
end
