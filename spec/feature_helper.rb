require 'spec_helper'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome, :args => ['--window-size=1280,800'])
end

Capybara.configure do |config|
  config.javascript_driver = :webkit
  config.default_max_wait_time = 10
  config.default_host = "http://127.0.0.1"
  config.server_port = Capybara::Server.new(nil).send(:find_available_port)
  WebMock.disable_net_connect!(allow: '127.0.0.1')
end

Capybara::Webkit.configure do |config|
  config.block_unknown_urls
end

RSpec.configure do |config|
  config.before do |example|
    Capybara.reset_sessions!
    CapybaraSupport.set_user_agent(example.metadata[:user_agent]) if example.metadata[:user_agent]
  end
end

def should_see(content)
  expect(page).to have_content(content)
end

def should_not_see(content)
  expect(page).not_to have_content(content)
end
