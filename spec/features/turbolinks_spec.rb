require 'spec_helper'

describe 'When viewing the application root' do
	it 'turbolinks is disabled' do
		visit root_path
		body.include?('<body data-no-turbolink="true">').should be_true
	end
end
