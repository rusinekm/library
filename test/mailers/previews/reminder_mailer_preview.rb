class ReminderMailerPreview < ActionMailer::Preview
  def three_days_left
    ReminderMailer.three_days_left(sample_user_book)
  end

  def book_expiration
    ReminderMailer.book_expiration(sample_user_book)
  end

  private

  def sample_user_book
    UserBook.new(
      borrow_time: 30.days.ago,
      user: User.new(full_name: "Preview User", email: "preview@example.com"),
      book: Book.new(title: "Preview Book", author: Author.new(full_name: "Preview Author"))
    )
  end
end