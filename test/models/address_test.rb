# == Schema Information
#
# Table name: addresses
#
#  id             :bigint           not null, primary key
#  address_type   :string
#  apartment_no   :string
#  city           :string
#  pin_code       :string
#  state          :string
#  street_address :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_addresses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class AddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
