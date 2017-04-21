# frozen_string_literal: true
require 'spec_helper'

describe 'College facet' do
  let(:user) { create :user }
  let(:subject_value) { 'mustache' }
  let!(:work) do
    create(:public_work,
           title: ["Toothbrush"],
           college: "Business",
           department: "Marketing",
           description: ['test'],
           user: user)
  end

  it 'appears' do
    visit '/catalog'
    expect(page).to have_css('div#facet-college_sim')
    expect(page).to have_css('a.facet_select', text: 'Business')
  end

  context 'when college selected' do
    it 'department facet appears' do
      visit '/catalog'
      click_link 'Business'

      expect(page).to have_css('div#facet-department_sim')
      expect(page).to have_css('a.facet_select', text: 'Marketing')
    end
  end

  context 'when college not selected' do
    it 'department facet does not appear' do
      visit '/catalog'

      expect(page).not_to have_css('div#facet-department_sim')
      expect(page).not_to have_css('a.facet_select', text: 'Marketing')
    end
  end
end
