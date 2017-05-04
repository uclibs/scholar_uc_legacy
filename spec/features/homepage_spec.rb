# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'the homepage', type: :feature do
  before do
    visit root_path
  end

  it 'renders the site title' do
    expect(page).to have_css('img[alt="scholar@uc"]')
  end

  it 'renders the contribute button' do
    expect(page).to have_css('a', text: 'Contribute')
  end

  it 'renders the discover button' do
    expect(page).to have_css('a', text: 'Browse')
  end

  it 'renders the splash controls' do
    expect(page).to have_content 'People'
    expect(page).to have_content 'About'
    expect(page).to have_content 'Contact'
    expect(page).to have_content 'Help'
  end

  it 'renders the jumbotron photo credit' do
    expect(page).to have_content 'Photo by fusion-of-horizons | CC-BY'
  end

  it 'renders the scholar headline' do
    expect(page).to have_css('span', class: 'line-thru', text: 'what is scholar@uc?')
  end

  it 'renders the scholar description' do
    expect(page).to have_css('div', class: 'scholar-home-tag-desc')
  end

  it 'renders the learn more link' do
    expect(page).to have_content 'Learn more about Scholar@UC'
  end

  it 'renders the featured researcher partial' do
    expect(page).to have_content 'FEATURED RESEARCHER'
  end

  it 'renders the featured collection partial' do
    expect(page).to have_content 'FEATURED COLLECTION'
  end

  it 'renders the featured work partial' do
    expect(page).to have_content 'FEATURED WORK'
  end

  it 'renders the external links' do
    expect(page).to have_css('div', class: 'ext-links')
  end

  it 'renders the partners headline' do
    expect(page).to have_css('span', class: 'line-thru', text: 'partners')
  end

  it 'renders the partner branding' do
    expect(page).to have_css('div', class: 'partner-branding')
  end

  it 'renders the partner links' do
    expect(page).to have_link(href: 'http://libraries.uc.edu')
    expect(page).to have_link(href: 'http://research.uc.edu')
    expect(page).to have_link(href: 'http://ucit.uc.edu')
    expect(page).to have_link(href: 'http://projecthydra.org')
  end
end
