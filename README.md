# README
This is a library app alllwng adding, removing books and lending them for library customers and returning them

after 27 and 30 days reminders about due date for returning books are sent


## design decisions
I have decided to include soft deleting of the books, rather than removing them directly, as this might be later expanded so that user might be able to see own history of borrowed books

I also decided for action of borrowing book automatically mark previous borrowing as returned. I assumed that this would be most likely decision due to input being used on some sort of bar code, qr code, or similar, so it would have to be physically present. I also allowed lending to the same user one after another time, as sort of extension of borrowing a book

Last decision I made was not to use pagination. Task specifically mentioned to include all books in index, so pagination might fail this part of task

## possible next development ideas

first idea is to add authentication and I would recommend to use devise gem for that

next idea might be to add some sort of RBAC, for example using pundit gem

I would also recommend adding pagination, for which I would recommend using pagy gem

Next I would think about expanding the app itself. For this I have ideas like adding also user endpoint for user input creation, limit of how many books can be borrowed at the same time, or some sort of frontend for the api




## Docker development

Start the application and PostgreSQL with:

docker compose up --build



The API is available at `http://localhost:3000`. The Rails database is created
and migrated automatically when the web container starts.

Stop the containers with `docker compose down`. To also remove the development
database volume, run `docker compose down --volumes`.

## running the application
possible routes to run the api are:

GET localhost:3000/api/books -> this returns index of the non deleted books
POST localhost:3000/api/books -> this creates a book and accepts nested params of books: {author: and title:} as query params
GET localhost:3000/api/books/:serial_number -> this is a show action that returns book, but accepts book's serial number, rather than id
DELETE localhost:3000/api/books/:serial_number -> this soft deletes a book record
POST localhost:3000/api/borrow_book -> this creates a borrowing of the book. It requires params of :serial_number and :library_card to make valid book borrowing record
DELETE localhost:3000/api/return_book -> this closes book borrowing if there exists one, where it wasn'e marked as returned

