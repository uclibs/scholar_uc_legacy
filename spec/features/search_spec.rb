require 'spec_helper'

describe 'Keyword search' do
  after(:each) do
    @object.destroy
  end

  it 'returns results for abstracts' do
    @object = create(:article, abstract: "abc123")

    visit('/')
    within('.search-form') do
      fill_in 'q', with: 'abc123'
      click_button("keyword-search-submit")
    end

    expect(page).to have_selector("#document_#{@object.noid}")
  end

  it 'returns results for alternative titles' do
    @object = create(:generic_work, alternate_title: "bcd234")

    visit('/')
    within('.search-form') do
      fill_in 'q', with: 'bcd234'
      click_button("keyword-search-submit")
    end

    expect(page).to have_selector("#document_#{@object.noid}")
  end

  it 'returns results for contributors' do
    @object = create(:generic_work, contributor: "cde345")

    visit('/')
    within('.search-form') do
      fill_in 'q', with: 'cde345'
      click_button("keyword-search-submit")
    end

    expect(page).to have_selector("#document_#{@object.noid}")
  end

  it 'returns results for coverage spatial' do
    @object = create(:generic_work, coverage_spatial: "def456")

    visit('/')
    within('.search-form') do
      fill_in 'q', with: 'def456'
      click_button("keyword-search-submit")
    end

    expect(page).to have_selector("#document_#{@object.noid}")
  end

  it 'returns results for coverage temporal' do
    @object = create(:generic_work, coverage_temporal: "efg567")

    visit('/')
    within('.search-form') do
      fill_in 'q', with: 'efg567'
      click_button("keyword-search-submit")
    end

    expect(page).to have_selector("#document_#{@object.noid}")
  end

  it 'returns results for creators' do
    @object = create(:generic_work, creator: "fgh678")

    visit('/')
    within('.search-form') do
      fill_in 'q', with: 'fgh678'
      click_button("keyword-search-submit")
    end

    expect(page).to have_selector("#document_#{@object.noid}")
  end

  it 'returns results for description' do
    @object = create(:generic_work, description: "ghi789")

    visit('/')
    within('.search-form') do
      fill_in 'q', with: 'ghi789'
      click_button("keyword-search-submit")
    end

    expect(page).to have_selector("#document_#{@object.noid}")
  end

  it 'returns results for genre' do
    @object = create(:document, genre: "Manuscript")

    visit('/')
    within('.search-form') do
      fill_in 'q', with: 'Manuscript'
      click_button("keyword-search-submit")
    end

    expect(page).to have_selector("#document_#{@object.noid}")
  end

  it 'returns results for journal title' do
    @object = create(:article, journal_title: "hij890")

    visit('/')
    within('.search-form') do
      fill_in 'q', with: 'hij890'
      click_button("keyword-search-submit")
    end

    expect(page).to have_selector("#document_#{@object.noid}")
  end

  it 'returns results for language' do
    @object = create(:generic_work, language: "ijk901")

    visit('/')
    within('.search-form') do
      fill_in 'q', with: 'ijk901'
      click_button("keyword-search-submit")
    end

    expect(page).to have_selector("#document_#{@object.noid}")
  end

  it 'returns results for publisher' do
    @object = create(:generic_work, publisher: "jkl012")

    visit('/')
    within('.search-form') do
      fill_in 'q', with: 'jkl012'
      click_button("keyword-search-submit")
    end

    expect(page).to have_selector("#document_#{@object.noid}")
  end

  it 'returns results for rights' do
    @object = create(:generic_work, rights: "klm123")

    visit('/')
    within('.search-form') do
      fill_in 'q', with: 'klm123'
      click_button("keyword-search-submit")
    end

    expect(page).to have_selector("#document_#{@object.noid}")
  end

  it 'returns results for type' do
    @object = create(:article, type: "lmn234")

    visit('/')
    within('.search-form') do
      fill_in 'q', with: 'lmn234'
      click_button("keyword-search-submit")
    end

    expect(page).to have_selector("#document_#{@object.noid}")
  end

  it 'returns results for title' do
    @object = create(:article, title: 'mno345')

    visit('/')
    within('.search-form') do
      fill_in 'q', with: 'mno345'
      click_button("keyword-search-submit")
    end

    expect(page).to have_selector("#document_#{@object.noid}")
  end

  it 'returns results for alternate phone number' do
    @object = create(:person, alternate_phone_number: '513-555-1234', email: "dave@example.com")
    @work = create(:article)
    @object.add_work(@work)
    visit('/')
    within('.search-form') do
      fill_in 'q', with: '513-555-1234'
      click_button("keyword-search-submit")
    end

    expect(page).to have_selector("#document_#{@object.noid}")
  end

  it 'returns results for blog' do
    @object = create(:person, blog: 'http://foo.wordpress.com')
    @work = create(:article)
    @object.add_work(@work)
    visit('/')
    within('.search-form') do
      fill_in 'q', with: 'http://foo.wordpress.com'
      click_button("keyword-search-submit")
    end

    expect(page).to have_selector("#document_#{@object.noid}")
  end

  it 'returns results for campus phone number' do
    @object = create(:person, campus_phone_number: '513-555-5678')
    @work = create(:article)
    @object.add_work(@work)
    visit('/')
    within('.search-form') do
      fill_in 'q', with: '513-555-5678'
      click_button("keyword-search-submit")
    end

    expect(page).to have_selector("#document_#{@object.noid}")
  end

  it 'returns results for personal web page' do
    @object = create(:person, personal_webpage: 'http://foo.geocities.com')
    @work = create(:article)
    @object.add_work(@work)
    visit('/')
    within('.search-form') do
      fill_in 'q', with: 'http://foo.geocities.com'
      click_button("keyword-search-submit")
    end

    expect(page).to have_selector("#document_#{@object.noid}")
  end

  it 'returns results for name' do
    @object = create(:person, name: 'James Foo Bar')
    @work = create(:article)
    @object.add_work(@work)
    visit('/')
    within('.search-form') do
      fill_in 'q', with: 'James Foo Bar'
      click_button("keyword-search-submit")
    end

    expect(page).to have_selector("#document_#{@object.noid}")
  end
end