require "date"

class UserBook < ApplicationRecord
    belongs_to :user
    belongs_to :book

    before_validation :set_borrow_time, on: :create


    def self.return_book_if_exists(user, book)
        existing_user_book = UserBook.find_by(user: user, book: book, return_time: nil)
        puts "Checking for existing user book:"
        puts existing_user_book.inspect
        existing_user_book.return_book if existing_user_book
    end

    def return_book
        self.return_time ||= DateTime.now
        self.save
    end

    def set_borrow_time
        self.borrow_time ||= DateTime.now
    end
end
