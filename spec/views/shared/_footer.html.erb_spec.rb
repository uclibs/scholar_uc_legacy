# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'shared/_footer.html.erb', type: :view do
  before do
    render
  end

  it 'displays a deployment timestamp' do
    expect(rendered).to have_content("Deployed on")
  end

  it 'displays a brought to you by statement' do
    expect(rendered).to have_content("Brought to you by")
  end

  it 'displays a made possible by statement' do
    expect(rendered).to have_content("Made possible by")
  end

  it 'displays a terms and discrimination statement' do
    expect(rendered).to have_content("Terms of Use")
    expect(rendered).to have_content("Non-Discrimination")
  end
end
