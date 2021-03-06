require 'watir-webdriver'
require 'page-object'
require 'faker'
require 'factory_girl'
require_relative '../../lib/mock_survey_site'



Around do |scenario, block|
  begin
    thread = Thread.new { Rack::Handler::WEBrick.run MockSurvey, {Port: 4567} }
    sleep 1
    @browser = Watir::Browser.new
    block.call
  rescue => e
    puts e.message
    puts e.backtrace
  ensure
    @browser.close
    thread.kill
  end
end

World(PageObject::PageFactory)
World(FactoryGirl::Syntax::Methods)
DataMagic.yml_directory = 'features/data'