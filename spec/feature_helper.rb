require 'spec_helper'

Capybara.configure do |config|
  config.javascript_driver = :webkit
  config.default_max_wait_time = 10
  config.default_host = "http://127.0.0.1"
  config.server_port = "52010"
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

  config.after do
    $redis.del(:exchange_rate)
  end

  # From http://stackoverflow.com/a/29967430/1009332
  config.before :example, perform_enqueued: true do
    @old_perform_enqueued_jobs = ActiveJob::Base.queue_adapter.perform_enqueued_jobs
    @old_perform_enqueued_at_jobs = ActiveJob::Base.queue_adapter.perform_enqueued_at_jobs
    ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
    ActiveJob::Base.queue_adapter.perform_enqueued_at_jobs = true
  end

  # From http://stackoverflow.com/a/29967430/1009332
  config.after :example, perform_enqueued: true do
    ActiveJob::Base.queue_adapter.perform_enqueued_jobs = @old_perform_enqueued_jobs
    ActiveJob::Base.queue_adapter.perform_enqueued_at_jobs = @old_perform_enqueued_at_jobs
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
  visit account_path
  click_link 'Logout'
  within '.nav' do
    should_see 'Login'
    should_see 'Signup'
  end
end
