Rails.application.routes.draw do
  namespace :api do
    post "borrow_book", to: "books/borrows#create"
    delete "return_book", to: "books/borrows#destroy"
    resources :books, param: :serial_number, only: [ :index, :create, :show, :destroy ]
  end
end
