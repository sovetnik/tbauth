# README

## Authentication service

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
2.4

* System dependencies
docker

* Configuration
create `dev.env` from `sample.env`, fill credentials
run 
```bash
docker-compose up --build
```

* Database creation
```bash
docker-compose run app rails db:create
```

* Database initialization
```bash
docker-compose run app rails db:migrate
```

