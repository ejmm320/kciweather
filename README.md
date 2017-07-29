# KCIWEATHER

I really enjoy doing this app, the concept is really simple, the main goal is getting from OpenWeather API the weather from any city of the world or from some random geographic coordinates.

Platform used for development:

## Ruby version

* ruby 2.4 
  
## System dependencies

* postgresql v9.4 or higher
* redis-server 

## Database creation

```ruby
rails db:create && rails db:migrate
```

## Database initialization

Not needed, because all info comes from the API and get stored in redis server with each request.

## How to run the test suite

```ruby
rspec
```

## Services (job queues, cache servers, search engines, etc.)

* [Open Weather Map API](http://openweathermap.org/API#weather)

## Deployment instructions

...
