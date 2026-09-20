class CreateUserbooks < ActiveRecord::Migration[8.0]
  def change
    create_table :user_books do |t|
      t.references :book
      t.references :user
      t.datetime :borrow_time
      t.datetime :return_time

      t.timestamps
    end
  end
end
