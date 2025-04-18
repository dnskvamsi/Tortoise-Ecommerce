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
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
