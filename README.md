# KCIWEATHER

I really enjoy doing this app, the concept is really simple, the main goal is getting from OpenWeather API the weather from any city of the world or from some random geographic coordinates.

Platform details:

## Ruby version

* ruby 2.4 
  
## System dependencies

* postgresql v9.4 or higher
* redis-server 

## Database creation

Go to psql or your prefered postgresql client and run:

```sql
CREATE ROLE kciweather with password 'kciweather' CREATEDB LOGIN;
```
Then go to app directory and execute:

```bash
$ rails db:reset && rails db:migrate
```

## Database initialization

Not needed, because all info comes from the API and get stored in redis server with each request.

## How to run the test suite

```bash
$ rspec
```

## Services (job queues, cache servers, search engines, etc.)

* [Open Weather Map API](http://openweathermap.org/API#weather)

## Notes

If you are a docker user please work with docker branch of this repo. 

