# == Schema Information
#
# Table name: tortoises
#
#  id            :bigint           not null, primary key
#  elite_design  :string
#  gender        :string
#  name          :string
#  price         :decimal(, )
#  quantity      :integer
#  shell_pattern :string
#  shell_texture :string
#  species       :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint
#
# Indexes
#
#  index_tortoises_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class TortoiseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
