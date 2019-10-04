require 'test_helper'

class ModelTest < ActiveSupport::TestCase
  4.times do |i|
    test "model_#{i}" do
      Rails.logger.info "Executing model test"
      assert true
    end
  end
end
