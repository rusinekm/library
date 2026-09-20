class Api::Books::BorrowsController < ApplicationController
    def create
        serial_number = params.require(:serial_number)
        library_card = params.require(:library_card)

        @book = Book.find_by!(serial_number: serial_number)
        @user = User.find_by!(library_card: library_card)
        UserBook.return_book_if_exists(@user, @book)
        @user_book = UserBook.create!(user: @user, book: @book, borrow_time: Time.current)
        head :created
    end

    def destroy
        serial_number = params.require(:serial_number)

        @book = Book.find_by!(serial_number: serial_number)
        @user_book = UserBook.find_by!(book: @book, return_time: nil)
        @user_book.update!(return_time: Time.current)
        head :ok
    end
end
