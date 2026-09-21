require 'rails_helper'

RSpec.describe 'Api::Books', type: :request do
  describe 'GET /api/books' do
    let(:books) { create_list(:book, 3) }
        let(:deleted_books) { create_list(:book, 3, deleted: true) }

    it 'returns available books' do
      books

      get '/api/books'

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to be_an(Array)
      expect(JSON.parse(response.body).size).to eq(3)
    end
     it 'returns only non deleted books' do
      books
    deleted_books
      get '/api/books'

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to be_an(Array)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET /api/books/:serial_number' do
    let(:book) { create(:book) }
    let(:user_books) { create_list(:user_book, 3, book: book) }
    it 'returns a specific book by serial_number' do
      user_books

      get "/api/books/#{book.serial_number}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['serial_number']).to eq(book.serial_number)
      expect(JSON.parse(response.body)['history'].size).to eq(3)
    end
  end

  describe 'POST /api/books' do
    it 'creates a book' do
      author = create(:author)
      books_before_adding = Book.all.count
      expect(books_before_adding).to eq(0)

      post '/api/books', params: {
        book: {
          author: author.full_name,
          title: 'New Title'
        }
      }
      expect(response).to have_http_status(:created)
      books_after_adding = Book.all.count
      expect(books_after_adding).to eq(books_before_adding + 1)
    end
  end
end
