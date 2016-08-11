require 'spec_helper'

describe 'Keyword search' do
  context 'for works' do
    after(:each) do
      @object.destroy
    end

    it 'returns results for advisor' do
      @object = create(:etd, advisor: "feomv048dj")

      visit('/')
      within('.search-form') do
        fill_in 'q', with: 'feomv048dj'
        click_button("keyword-search-submit")
      end

      expect(page).to have_selector("#document_#{@object.noid}")
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

    it 'returns results for committee_members' do
      @object = create(:etd, committee_member: "deofh49585")

      visit('/')
      within('.search-form') do
        fill_in 'q', with: 'deofh49585'
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

    it 'returns results for date created' do
      @object = create(:generic_work, date_created: '1990-01-02')

      visit('/')
      within('.search-form') do
        fill_in 'q', with: '1990-01-02'
        click_button("keyword-search-submit")
      end

      expect(page).to have_selector("#document_#{@object.noid}")
    end

    it 'returns results for notes' do
      @object = create(:generic_work, note: 'hfas123645')

      visit('/')
      within('.search-form') do
        fill_in 'q', with: 'hfas123645'
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
  end

  context "for people" do
    let!(:account) { FactoryGirl.create(:account, first_name: 'Bruce', last_name: 'Banner', personal_webpage: 'http://foo.geocities.com', campus_phone_number: '513-555-5678', alternate_phone_number: '513-555-1234', email: "dave@example.com", blog: 'http://foo.wordpress.com') }
    let!(:user) { account.user }
    let!(:person) { account.person }
    before {login_as(user)}

    it 'returns results for alternate phone number' do
      @object = create(:generic_work, title: "This is the title.", description: "This is the description.")
      visit('/')
      within('.search-form') do
        fill_in 'q', with: '513-555-1234'
        click_button("keyword-search-submit")
      end

      expect(page).to have_link("Bruce Banner")
    end

    it 'returns results for blog' do
      @object = create(:generic_work, title: "This is the title.", description: "This is the description.")
      visit('/')
      within('.search-form') do
        fill_in 'q', with: 'http://foo.wordpress.com'
        click_button("keyword-search-submit")
      end

      expect(page).to have_link("Bruce Banner")
    end

    it 'returns results for campus phone number' do
      @object = create(:generic_work, title: "This is the title.", description: "This is the description.")
      visit('/')
      within('.search-form') do
        fill_in 'q', with: '513-555-5678'
        click_button("keyword-search-submit")
      end

      expect(page).to have_link("Bruce Banner")
    end

    it 'returns results for personal web page' do
      @object = create(:generic_work, title: "This is the title.", description: "This is the description.")
      visit('/')
      within('.search-form') do
        fill_in 'q', with: 'http://foo.geocities.com'
        click_button("keyword-search-submit")
      end

      expect(page).to have_link("Bruce Banner")
    end

    it 'returns results for first name' do
      @object = create(:generic_work, title: "This is the title.", description: "This is the description.")
      visit('/')
      within('.search-form') do
        fill_in 'q', with: 'Bruce'
        click_button("keyword-search-submit")
      end

      expect(page).to have_link("Bruce Banner")
    end

    it 'returns results for last name' do
      @object = create(:generic_work, title: "This is the title.", description: "This is the description.")
      visit('/')
      within('.search-form') do
        fill_in 'q', with: 'Banner'
        click_button("keyword-search-submit")
      end

      expect(page).to have_link("Bruce Banner")
    end
  end
end
