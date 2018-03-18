class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :retweet_id, class_name: 'Tweet', foreign_key: 'parent_id'
  has_many :mentions
  has_many :hashtags
  has_many :likes

end