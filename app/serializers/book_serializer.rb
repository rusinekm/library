class BookSerializer
  def initialize(book)
    @book = book
  end

  def serializable_hash
    active_user = @book.users.last
    borrowed = @book.user_books.where(return_time: nil).exists?

    {
      id: @book.id,
      title: @book.title,
      serial_number: @book.serial_number,
      author_id: @book.author_id,
      author: @book.author&.full_name,
      borrowed: borrowed,
      user: active_user && {
        id: active_user.id,
        full_name: active_user.full_name,
        email: active_user.email
      }
    }
  end

  def serializable_full_history_hash
    serializable_hash.merge(
      history: @book.all_user_books.order(:borrow_time).map do |user_book|
        {
          user_name: user_book.user.full_name,
          borrowed_at: strftime(user_book.borrow_time),
          returned_at: strftime(user_book.return_time)
        }
      end
    )
  end
  private

  def strftime(datetime)
    datetime&.strftime("%Y-%m-%d %H:%M:%S")
  end
end
