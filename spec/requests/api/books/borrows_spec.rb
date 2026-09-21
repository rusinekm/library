require 'rails_helper'

RSpec.describe 'Api::Books::Borrows', type: :request do
  describe 'POST /api/borrow_book' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }
    it 'borrows a book for a user' do
      post '/api/borrow_book', params: {
        serial_number: book.serial_number,
        library_card: user.library_card
      }

      expect(response).to have_http_status(:created)
      expect(book.reload.is_borrowed?).to be true
    end
  end

  describe 'DELETE /api/return_book' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }

    it 'returns a borrowed book' do
      create(:user_book, user: user, book: book, return_time: nil)

      delete '/api/return_book', params: {
        serial_number: book.serial_number
      }

      expect(response).to have_http_status(:ok)
      expect(book.reload.is_borrowed?).to be false
    end
  end
end
