# Library

This library API supports adding and removing books, lending them to library customers, and recording their return.

Borrowers receive return reminders after 27 and 30 days.

## Design Decisions

Books are soft-deleted rather than removed directly. This leaves room for users to view their borrowing history later.

Borrowing a book automatically marks any previous active borrowing of that book as returned. This assumes a barcode or QR code scan requires the physical book to be present. The same user can borrow a book again as an extension of the loan.

Pagination is not included because the task requires the index endpoint to return all books.

## Possible Future Development

- Add authentication with the `devise` gem.
- Add role-based access control with the `pundit` gem.
- Add pagination with the `pagy` gem.
- Add user-management endpoints, borrowing limits, or a frontend for the API.

## Docker Development

Copy the example environment configuration before starting the application:

```sh
cp .env.example .env
```

Start the application and PostgreSQL with:

```sh
docker compose up --build
```

The API is available at `http://localhost:3000`. The Rails database is created
and migrated automatically when the web container starts.

Stop the containers with `docker compose down`. To also remove the development
database volume, run `docker compose down --volumes`.

## API Endpoints

- `GET /api/books`: Returns all non-deleted books.
- `POST /api/books`: Creates a book. Accepts nested `book` parameters for `author` and `title`.
- `GET /api/books/:serial_number`: Returns a book by serial number.
- `DELETE /api/books/:serial_number`: Soft-deletes a book.
- `POST /api/borrow_book`: Borrows a book. Requires `serial_number` and `library_card` parameters.
- `DELETE /api/return_book`: Closes an active borrowing record, if one exists.

