class User < ApplicationRecord
  has_secure_password
  validates_confirmation_of :password
  validates_presence_of :password_confirmation
  validates_length_of :password, minimum: 8, if: :password_required?
  validates_uniqueness_of :email, case_sensitive: false
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true


  def password_required?
    new_record? || password.present?
  end

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    user && user.authenticate(password) ? user : nil
  end
end
