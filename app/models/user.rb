class User < ActiveRecord::Base
  has_many :tweets
  has_many :followers
  has_many :likes
  has_many :mentions
  has_many :hashtags
end