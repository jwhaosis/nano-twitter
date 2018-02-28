require 'bcrypt'

class User < ActiveRecord::Base

  # validates :name,  presence: true, length: { maximum: 50 }
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, length: { maximum: 255 },
  #           format: { with: VALID_EMAIL_REGEX },
  #           uniqueness: { case_sensitive: false }

  has_many :tweets
  has_many :followers
  has_many :likes
  has_many :mentions
  has_many :hashtags

  # users.password_hash in the database is a :string
  include BCrypt

  def password
    @password_digest ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password_digest = Password.create(new_password)
    self.password_hash = @password_digest
  end
end