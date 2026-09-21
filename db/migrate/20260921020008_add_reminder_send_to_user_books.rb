class AddReminderSendToUserBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :user_books, :three_days_left_reminder_sent, :boolean, default: false
    add_column :user_books, :book_expiration_reminder_sent, :boolean, default: false
  end
end
