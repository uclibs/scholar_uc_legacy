# frozen_string_literal: true
require 'rails_helper'

describe '/hyrax/contact_form/new.html.erb', type: :view do
  before do
    view.stub(:user_signed_in?) { false }
    allow(view).to receive(:current_user).and_return('')
    @contact_form = Hyrax::ContactForm.new
    params['subject'] = 'This is the subject'
    params['message'] = 'This is the message'
    render
  end

  it 'includes the passed subject text to the form' do
    expect(rendered).to have_selector('input[name="contact_form[subject]"][value="This is the subject"]')
  end

  it 'includes the passed message text to the form' do
    expect(rendered).to have_content('This is the message')
  end
end
