# README

![Sample image](https://i.imgur.com/erXhppL.png)


## ABOUT

This application was developed as a challenge of the Indeva hiring test


## Dependencies

* Docker
* Docker Compose


## How to use

```sh
1. docker-compose build
2. docker-compose run --rm app bundle install
3. docker-compose run --rm app bundle exec rails db:create
4. docker-compose run --rm app bundle exec rails db:migrate
5. docker-compose up
```
