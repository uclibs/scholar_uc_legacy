# frozen_string_literal: true
require 'rails_helper'

describe 'Blacklight pagination', type: :feature do
  let(:user)   { create :user }
  let!(:work)  { create :public_work, user: user }
  let!(:work2) { create :public_work, user: user }

  context 'when there are more page(s) after this one' do
    before do
      visit '/catalog?per_page=1&page=1'
    end

    it 'displays a Next link' do
      expect(page).to have_css('span.next', text: 'Next »')
    end

    it 'displays a Last link' do
      expect(page).to have_css('span.last', text: 'Last »')
    end
  end

  context 'when there are more page(s) before this one' do
    before do
      visit '/catalog?per_page=1&page=2'
    end

    it 'displays a Previous link' do
      expect(page).to have_css('span.prev', text: '« Previous')
    end

    it 'displays a First link' do
      expect(page).to have_css('span.first', text: '« First')
    end
  end

  context 'when on the first page' do
    before do
      visit '/catalog?per_page=1&page=1'
    end

    it 'does not display a Previous link' do
      expect(page).not_to have_css('span.prev', text: '« Previous')
    end

    it 'does not display a First link' do
      expect(page).not_to have_css('span.first', text: '« First')
    end
  end

  context 'when on the last page' do
    before do
      visit '/catalog?per_page=1&page=2'
    end

    it 'does not display a Next link' do
      expect(page).not_to have_css('span.next', text: 'Next »')
    end

    it 'does not display a Last link' do
      expect(page).not_to have_css('span.last', text: 'Last »')
    end
  end
end
