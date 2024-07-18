# Geolocation API

> Ruby version: ruby "3.1.2"

## Steps to run the API service

1. clone this repo
2. run `bundle install`
3. run `rails db:migrate`
4. create an `.env` file
5. paste your `IPSTACK_API_KEY`
4. run `rails s` or `rails server`

## Usage

You can use tools like `curl` or `Postman` to test the API endpoints:

> Create Geolocation

replace `your_ip_address_or_url` for the IP you want to store (e.g.: www.google.com)

```sh
curl -X POST -H "Content-Type: application/json" -d '{"ip_or_url":"your_ip_address_or_url"}' http://localhost:3000/geolocations
```

> Show Geolocation

```sh
curl http://localhost:3000/geolocations/1
```

> Delete Geolocation

```sh
curl -X DELETE http://localhost:3000/geolocations/1
```

## Tests

```sh
rspec spec/controllers/geolocations_controller_spec.rb
```

