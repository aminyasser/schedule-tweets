# Schedule Tweets 

Built Rails Schedule Twitter Tweets to practice on ROR and twitter API. Using Sidekiq as Backgroud Job for Scheduled Tweets.

## Features

- Authentication
- Connect Twitter Account 
- Schedule Tweet 
- Edit Scheduled

## Running locally 

clone the repo and then install the needed gems
```bash
bundle install
```
In path ``config/database.yml`` add your own configrations.
```ruby
default: &default
  adapter: mysql2
  encoding: utf8mb4
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: root
  password:
  host: localhost

development:
  <<: *default
  database: your-db-name
```
migrate the database
```bash
rails db:migrate
```
Add your twitter API credentials 
```bash
rails credentials:edit --environment=development
```
```ruby
twitter:
    api_key: your-api-key
    api_secret: your-api-secret
```
serve the app
```bash
 rails server
```
start Sidekiq (You need to have redis installed on your local machine)

```bash
sidekiq
```

## Demo








