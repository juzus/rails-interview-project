# Questions API

To run locally, execute the following commands in your terminal:

```
bundle install
bin/rails db:setup
rails s
```

## API

### Get a list of questions

HTTP Request To Access the Resource Locally:

`http://localhost:3000/tenants/<api_key>/questions`

You must pass in a valid tenant api_key in order to receive the questions response.

## Dashboard Web Application

Navigate to `http://localhost:3000` to see a simple dashboard showing the total number of Questions, Answers, and Users, along with a table displaying all of the valid Tenants' request counts.

## Tests

This application uses RSpec and FactoryBot for testing.

Run RSpec tests by executing the following command:

`bundle exec rspec`

For any questions, please contact julia.l.allen@gmail.com

Enjoy!
