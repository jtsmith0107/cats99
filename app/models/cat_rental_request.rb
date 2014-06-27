# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string(255)      default("PENDING")
#  created_at :datetime
#  updated_at :datetime
#

class CatRentalRequest < ActiveRecord::Base
  belongs_to(
    :cat,
    :class_name => 'Cat'
  )
  
  belongs_to(
  :requester,
  :class_name => 'User',
  :foreign_key => :user_id
  )
  
  
  before_validation(on: :status) do
    self.status ||= "PENDING"
  end
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, :inclusion => { in: %w(APPROVED DENIED PENDING), 
                                      message: "%{value} is not a valid status."}
  
   validate :overlapping_approved_requests
   validate :start_date_before_end_date
  def overlapping_requests    
    CatRentalRequest.all.where(<<-SQL,start_date,end_date,start_date, end_date,cat_id)
    ((? BETWEEN start_date AND end_date) OR (? BETWEEN start_date AND end_date) OR
    (start_date < ? AND end_date > ?)) AND (cat_id = ?)
    SQL
  end
  
  def overlapping_approved_requests
    approved_stati = overlapping_requests.where(status: 'APPROVED')
    
    unless approved_stati.empty?
      errors[:status] << "Two overlapping requests cannot be approved"      
    end
  end
  
  def start_date_before_end_date
    unless start_date < end_date
      error[:base] << "Start date must be before end date"
    end
  end
  
  def rental_persisted
   if self.persisted? 
     return 'Update Cat Rental Request'
   else
     return 'Create Cat Rental Request'
   end    
  end  
  
end
