ENV['RACK_ENV'] = 'test'
require_relative '../config/init'
require 'rack/test'
require 'minitest/autorun'

include Rack::Test::Methods
