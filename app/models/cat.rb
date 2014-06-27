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

class Cat < ActiveRecord::Base
  COLORS = %w(black brown white orange calico)
  belongs_to :owner, class_name: "User", foreign_key: :user_id 
  
  has_many(
    :cat_rental_requests,
    :class_name => 'CatRentalRequest',
    dependent: :destroy
  )
  
  has_many :requests, :through => :cat_rental_requests, :source => :requester
  
  # def destroy
  #   cat_rental_requests.destroy
  #   self.destroy
  # end
  
  validates :age, :numericality  => true, :presence  => true
  validates :birth_date, :color, :name, :sex, :presence  => true
  validates :color, :inclusion  => { in: COLORS,
                                      message: "%{value} is not a valid color."}
  validates :sex, :inclusion  => { in: %w(M F), message: "%{value} is not a valid sex."}
end
