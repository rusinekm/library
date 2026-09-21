# README

## Docker development

Start the application and PostgreSQL with:

```sh
docker compose up --build
```

The API is available at `http://localhost:3000`. The Rails database is created
and migrated automatically when the web container starts.

Stop the containers with `docker compose down`. To also remove the development
database volume, run `docker compose down --volumes`.

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
