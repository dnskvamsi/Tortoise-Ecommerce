# Team Coral

## Team Members

- Aishwarya Patil (aishwaryapatil0401@gmail.com)
- Girish Chalamalasetti (girishnaidu05@gmail.com)
- Renu Sri Pabboju (renusripabboju@gmail.com)
- Laxmi Pranaya Yennam (yennamlaxmipranaya@gmail.com)

## How to Initialize and Run the App

### Prerequisites

- **RVM** is assumed (see [Rails Demos-n-Deets](https://rails-demos-n-deets-2023.herokuapp.com/demos/development-environment) for setup instructions).
- **Ruby version 3.1.2** is required.
  - `rvm install 3.1.2` - Install Ruby 3.1.2 using RVM.
- **Bundler** is required (see [Rails Demos-n-Deets](https://rails-demos-n-deets-2023.herokuapp.com/demos/development-environment) for setup instructions).
- **PostgreSQL** is required  (see [Rails Demos-n-Deets](https://rails-demos-n-deets-2023.herokuapp.com/demos/development-environment) for setup instructions).
- **NodeJS** is required (see [Rails Demos-n-Deets](https://rails-demos-n-deets-2023.herokuapp.com/demos/development-environment) for setup instructions).

### Initializing the App

- `bundle install` - Install all the necessary gems.
- `rails db:migrate:reset` - Reset and initialize the database.
- `rails db:seed` - Save seed data to the database (see `db/seeds.rb`).
  - No seed data is included in the base app.

### Running the App

- `rails server` - Run the development web server.
- Open <http://localhost:3000/> in the browser to launch the app (root page).

## Included with the Base App

- **[Devise](https://github.com/heartcombo/devise#readme)**
  - A Devise `User` class has been generated (see `app/model/user.rb`).
  - The Devise view templates have been added (see `app/views/devise/`).
- **[Bootstrap v5.2.3](https://getbootstrap.com/docs/5.2/getting-started/introduction/)**
- **[BootSwatch v5.2.3](https://bootswatch.com/)**
  - A list of BootSwatch themes can be found [here](https://bootswatch.com/).
  - The [Darkly theme](https://bootswatch.com/darkly/) is set by default (see `app/assets/stylesheets/application.scss`).
- **Flash Notifications**
  - Implemented as per the [Rails Demos-n-Deets](https://rails-demos-n-deets-2023.herokuapp.com/deets/flash-notifications).
- **Home Page**
  - A `HomeController` with a `show` action and view template is included.
  - The root route is set to this `show` action (see `config/routes.rb`).
