class Api::BooksController < ApplicationController
    def index
        books = Book.includes(:author, :users, :user_books)
                    .where(deleted: false)
                    .left_joins(:user_books)
                    .where(user_books: { return_time: nil })
        render json: serialize_books(books)
    end

    def show
        @book = Book.find_by!(serial_number: params[:serial_number])
        render json: serialize_single_book(@book)
    end

    def create
        find_of_create_author
        @book = Book.create!(book_params.merge(author_id: @author.id))
        head :created
    end

    def destroy
        @book = Book.find_by!(serial_number: params[:serial_number])
        UserBook.mark_any_returns_for_book(@book)
        @book.update!(deleted: true)
        head :ok
    end

private

def serialize_book(book)
    ::BookSerializer.new(book).serializable_hash
end

def serialize_books(books)
    Array(books).map { |book| serialize_book(book) }
end

def serialize_single_book(book)
    ::BookSerializer.new(book).serializable_full_history_hash
end

def book_params
    params.require(:book).permit(:title)
end

def find_of_create_author
    @author ||= Author.find_by(full_name: params[:book][:author]) || Author.create!(full_name: params[:book][:author])
end
end
