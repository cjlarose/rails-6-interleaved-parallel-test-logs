require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  4.times do |i|
    test "controller_#{i}" do
      Rails.logger.info "Executing controller test"
      get articles_url
      assert_response :success
    end
  end
end
