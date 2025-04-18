# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Users

user1 = User.create!(
  email:    'alice@email.com',
  password: 'password',
  first_name: 'Alice'
)

user2 = User.create!(
  email:    'bob@email.com',
  password: 'password',
  first_name: 'Bob'
)

user3 = User.create!(
  email:    'vendor@email.com',
  password: 'password',
  role: :vendor,
  first_name: 'Vendor'
)

User.create!(
  email: 'customerExecutive@gmail.com',
  password: 'password',
  role: :customer_executive,
  first_name: 'Executive'
)

User.create!(
  email: 'admin@gmail.com',
  password: 'password',
  role: :admin,
  first_name: 'Admin'
)


tortoises = Tortoise.create([
  {
    name: 'Herm',
    gender: 'Female',
    species: 'Hermanns Tortoise',
    shell_pattern: 'Saddleback',
    shell_texture: 'Rough',
    elite_design: true,
    price: 49.99,
    user: user3,
    quantity: 1

  },
  {
    name: 'Egyp',
    gender: 'Male',
    species: 'Egyptian Tortoise',
    shell_pattern: 'Domed',
    shell_texture: 'Scaly',
    elite_design: true,
    price: 59.99,
    user: user3,
    quantity: 1
  },
  {
    name: 'Leo',
    gender: 'Male',
    species: 'Leopard Tortoise',
    shell_pattern: 'Brown',
    shell_texture: 'Geometric',
    elite_design: false,
    price: 39.99,
    user: user3,
    quantity: 1
  },
  {
    name: 'Russ',
    gender: 'Male',
    species: 'Russian tortoise',
    shell_pattern: 'Brown',
    shell_texture: 'Geometric',
    elite_design: true,
    price: 69.99,
    user: user3,
    quantity: 1
  },
  {
    name: 'Herm',
    gender: 'Male',
    species: 'Hermanns Tortoise',
    shell_pattern: 'Saddleback',
    shell_texture: 'Rough',
    elite_design: true,
    price: 65.99,
    user: user3,
    quantity: 1
  },
  {
    name: 'Russ',
    gender: 'Female',
    species: 'Russian tortoise',
    shell_pattern: 'Brown',
    shell_texture: 'Geometric',
    elite_design: true,
    price: 69.99,
    user: user3,
    quantity: 1
  }
])
