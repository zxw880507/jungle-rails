# frozen_string_literal: true

class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 4 }
  validates :password_confirmation, presence: true
  has_secure_password
  before_save :email_downcase

  def self.authenticate_with_credentials(email, password)
    email_formatting = email.strip.downcase
    user = find_by_email(email_formatting)
    user if user&.authenticate(password)
  end

  private

  def email_downcase
    email.downcase!
  end
end
