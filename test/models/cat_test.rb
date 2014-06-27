# == Schema Information
#
# Table name: cats
#
#  id         :integer          not null, primary key
#  age        :integer          not null
#  birth_date :string(255)      not null
#  color      :string(255)      not null
#  name       :string(255)      not null
#  sex        :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class CatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
