# KCIWEATHER

I really enjoy doing this app, the concept is really simple, the main goal is getting from OpenWeather API the weather from any city of the world or from some random geographic coordinates.

Platform details:

## Ruby version

* ruby 2.4 
  
## System dependencies

* postgresql v9.4 or higher
* redis-server
* docker
* docker-compose 

## In order to get the project running

Clone the project into your machine and then execute:

```bash
$ docker-compose up --build
```

Open another console and run:

* For linux users:

```bash
$ docker-compose exec --user "$(id -u):$(id -g)" website rails db:reset
$ docker-compose exec --user "$(id -u):$(id -g)" website rails db:migrate
```
If not using linux remove the --user flag.

## Database initialization

Not needed, because all info comes from the API and get stored in redis server with each request.

## How to run the test suite

```bash
$ docker-compose run --user "$(id -u):$(id -g)" website rspec
```

## Services (job queues, cache servers, search engines, etc.)

* [Open Weather Map API](http://openweathermap.org/API#weather)

## Notes 

* If there is a problem running the project / test suite:

```bash
$ docker-compose run --user "$(id -u):$(id -g)" website rake tmp:cache:clear
```

* If you are not using docker please work with the master branch
