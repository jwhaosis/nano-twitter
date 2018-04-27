ENV['RACK_ENV'] = 'test'
# require_relative '../config/ig/init'
require 'minitest/autorun'
require 'rack/test'
require_relative '../app'

# require 'rspec'

# enable :sessions
include Rack::Test::Methods
