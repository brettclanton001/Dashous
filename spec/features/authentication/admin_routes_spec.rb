require 'feature_helper'

feature 'Admin Routes', js: true do

  context 'Resque' do
    given(:user) { create :user, email: Settings.admin.email }

    background do
      login_as user
    end

    Steps 'Can access Resque' do
      When 'I try to visit the resque page' do
        visit '/resque'
      end
      Then 'I do see the resque page' do
        should_see 'Workers Working'
      end
    end
  end
end
