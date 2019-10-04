ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require_relative './parallel_testing_tagged_logging'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: 2, with: ENV.fetch('PARALLELIZE_WITH', 'processes').to_sym)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
