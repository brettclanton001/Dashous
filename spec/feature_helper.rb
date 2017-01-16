require 'spec_helper'

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
    stub_price(10)
  end
end

def stub_price(price)
  $redis.del(:exchange_rate)
  ExchangeRateService::CURRENCIES.each do |currency|
    stub_request(:get, "https://api.cryptonator.com/api/ticker/dash-#{currency}").to_return(
      status: 200,
      body: {
        ticker: {
          base: 'DASH',
          target: currency.upcase,
          price: price,
          volume: '2056.78697840',
          change: '0.04682657'
        },
        timestamp: 1481982394,
        success: true,
        error: ''
      }.to_json,
      headers: {}
    )
  end
end

def should_be_located(path)
  expect(page.current_url).to eq "#{page.current_host}:#{Capybara.server_port}#{path}"
end

def login_as(user)
  visit new_user_session_path
  fill_in :user_username, with: user.username
  fill_in :user_password, with: 'password'
  click_button 'Login'
  within '.nav' do
    should_see 'Account'
  end
end

def logout
  visit account_index_path
  click_link 'Logout'
  within '.nav' do
    should_see 'Login'
    should_see 'Signup'
  end
end
