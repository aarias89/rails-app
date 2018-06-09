# README

Ruby on Rails blog application using ActionCable for realtime chat/response.
The application was built MVC  design pattern along with BDD practice.

rails version 5.1

## Testing
### Rpec & Capybara- Tests Covered
### Unit Tests
-Models

-Views

-Routes

###Functional Tests
-Controllers

###Integrational Tests
-Emulation User

-Process followed to completion to meet objective

## Installation

```bash
git clone https://github.com/aarias89/rails-app.git
```

## Run Locally

```bash
bundle install
```

```
rails db:create
```

```
rails db:migrate
```

```
rails s -p 3001
```

On browser go to http://localhost:3001/
## Run Tests

Open separate tab on terminal and run the following:

```
bundle binstubs guard
```

```
guard init
```

```
guard
```

## Heroku
Deployed  [RailsBlogApp](https://rails-chatapp.herokuapp.com/).