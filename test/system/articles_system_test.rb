require "application_system_test_case"

class ArticlesSystemTest < ApplicationSystemTestCase
  4.times do |i|
    test "system_#{i}" do
      Rails.logger.info "Executing system test"
      visit articles_url
      assert_selector "h1", text: "Articles"
    end
  end
end
