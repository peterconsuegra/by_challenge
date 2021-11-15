# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

3.0.2

* Configuration

bundle install

* Database creation

rake db:create db:migrate

* How to run the test suite

bundle exec rake db:test:prepare
bundle exec rspec spec/requests/orders_request_spec.rb

* How to run the rails app

bundle exec rails s

* Notes...

* Postman set

Body -> form-data
Key: order[line_items_attributes][]
Value {quantity:2, amount:10}

* Order controller logic 

data = {order: { line_items_attributes: [{ quantity: 2, amount: 10 }, { quantity: 3, amount: 10 }] }}

params = ActionController::Parameters.new(data)

permitted_params = params.require(:order).permit(:id, :line_items_attributes => [])

order = Order.create!(permitted_params)

order = Order.update!(permitted_params)

* REGEX

REGEX 
v1
regexp =/\{\s*quantity:.*,\s*amount:.*}/
regexp.match?("{quantity:2, amount:10}")

v2
regexp = /\{\s*quantity:\s*[0-9]+\s*,\s*amount:\s*[0-9]+\s*}/
regexp.match?("{quantity:2, amount:10}")

