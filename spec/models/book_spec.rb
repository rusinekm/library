require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
  let(:author) { create(:author) }
  let(:build_book) { build(:book, title: Faker::Book.title, author_id: author.id, deleted: false) }
  let(:build_book_without_title) { build(:book, title: nil, author_id: author.id, deleted: false) }

    it 'is valid with a title, author, and serial_number' do
      expect(build_book).to be_valid
    end

    it 'is invalid without a title' do
      expect(build_book_without_title).not_to be_valid
    end
  end

  describe '#is_borrowed?' do
    let(:author) { create(:author) }

   let(:created_book) { create(:book, title: Faker::Book.title, author_id: author.id, deleted: false) }
    let(:user_book) { create(:user_book, book: created_book) }

    it 'returns true when a user_book is active' do
      created_book
      user_book

      expect(created_book.is_borrowed?).to be true
    end
  end
end
