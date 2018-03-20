# ENV['RACK_ENV'] = 'test'
# require_relative '../config/ig/init'
require 'rack/test'
require 'minitest/autorun'

include Rack::Test::Methods
