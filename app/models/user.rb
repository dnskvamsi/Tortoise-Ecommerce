# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  card_holder_name       :string
#  card_number            :string
#  cvv                    :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  expiry_date            :string
#  first_name             :string
#  last_name              :string
#  phone_number           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Associations
  has_many :wishlists, dependent: :destroy
  has_many :wishlist_tortoises, through: :wishlists, source: :tortoise
  has_many :wishlist_accessories, through: :wishlists, source: :accessory
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :reviewed_products, through: :reviews, source: :tortoise
  has_many :chat_participations
  has_many :chat_sessions, through: :chat_participations
  has_many :messages
  has_many :likes, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :profiles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :faqs, dependent: :destroy
  has_many :accessories, dependent: :destroy

  has_many(
    :tortoises,
    class_name: 'Tortoise',
    foreign_key: 'user_id'
  )

  enum :role, [:admin, :customer, :vendor, :customer_executive], default: :customer

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :email, presence: true
end
