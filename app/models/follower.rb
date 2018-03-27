require 'active_record'

class Follower < ActiveRecord::Base
  belongs_to :user
  has_many :users
end
