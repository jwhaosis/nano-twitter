class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :tweets #, class_name: "Tweet", foreign_key: "tweet_id"
  has_many :mentions
  has_many :hashtags
  has_many :likes

end