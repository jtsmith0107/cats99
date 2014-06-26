class Cat < ActiveRecord::Base
  COLORS = %w(black brown white orange calico)
  
  has_many(
    :cat_rental_requests,
    :class_name => 'CatRentalRequest',
    dependent: :destroy
  )
  
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
