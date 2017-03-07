# README

## Authentication service

Service accept redirect to /token?key=xxx from [client](https://github.com/sovetnik/tbclient) where xxx is base64 encoded Public key.
When redirected user has session and authenticated, service get token from user, encode it with Public key, after base64 and redirect back to referrer with encoded token.

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
2.4

* System dependencies
docker

* Configuration
create `dev.env` from `sample.env`, fill credentials and run
```bash
docker-compose up --build
```

* Database creation
```bash
docker-compose run app rails db:create db:migrate
```
