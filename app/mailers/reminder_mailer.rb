class ReminderMailer < ApplicationMailer
  def self.send_3_days_left_notifications
    UserBook.where(return_time: nil, three_days_left_reminder_sent: false)
      .where("borrow_time <= ?", 27.days.ago)
      .find_each do |user_book|
        three_days_left(user_book).deliver_later
        user_book.update!(three_days_left_reminder_sent: true)
      end
  end

  def self.book_expiration_notifications
    UserBook.where(return_time: nil, book_expiration_reminder_sent: false)
      .where("borrow_time <= ?", 30.days.ago)
      .find_each do |user_book|
        book_expiration(user_book).deliver_later
        user_book.update!(book_expiration_reminder_sent: true)
      end
  end

  def book_expiration(user_book)
    @user_book = user_book

    mail(
      to: user_book.user.email,
      subject: "Library book return reminder"
    )
  end

  def three_days_left(user_book)
    @user_book = user_book

    mail(
      to: user_book.user.email,
      subject: "Library book return reminder"
    )
  end
end