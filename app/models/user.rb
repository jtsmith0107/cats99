# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#
require 'bcrypt'
class User < ActiveRecord::Base
  
  has_many :cats
  has_many :cat_rental_requests, class_name: 'CatRentalRequest', foreign_key: :user_id 
  has_many :rentals, :through => :cat_rental_requests, :source => :cat
  
  def password
    @password
  end
  
  validates :username, :password_digest, :session_token, presence: true
  validates :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  
  before_validation :ensure_session_token
  
  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token  
  end
  
  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def self.find_by_credentials(user_name, password)
    user = User.find_by_username(user_name)
    return user if !user.nil? && user.is_password?(password)
    nil
  end
end
