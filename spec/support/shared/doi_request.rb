# frozen_string_literal: true

shared_examples 'doi request' do |work_class|
  let(:user) { create(:user) }
  let(:work_without_doi) do
    create("#{work_class.to_s.underscore}_with_one_file".to_sym,
           title: ["Magnificent splendor"],
           source: ["The Internet"],
           based_near: ["USA"],
           visibility: "open",
           user: user)
  end

  let(:work_with_doi) do
    create("#{work_class.to_s.underscore}_with_one_file".to_sym,
           title: ["Magnificent splendor"],
           source: ["The Internet"],
           based_near: ["USA"],
           doi: "doi:1234foo",
           visibility: "open",
           user: user)
  end

  let(:work_label) { work_class.name.underscore }
  let(:work_text) { work_class.name.titlecase }

  before do
    CurationConcerns::Workflow::WorkflowImporter.load_workflows
    Sufia::AdminSetCreateService.create_default!
    allow(CharacterizeJob).to receive(:perform_later)
  end

  context 'creating a work' do
    before do
      login_as user
      visit new_polymorphic_path(work_class)
    end

    it 'displays the request option in the work edit form' do
      click_link "DOI" # switch tab
      expect(page).to have_content "Yes, I would like to create a DOI for this #{work_text}."
      expect(page).to have_content "Not now…but maybe later."
    end

    it 'mints a DOI for the work' do
      click_link "DOI" # switch tab
      choose('mint-doi')
      click_link "Files" # switch tab
      attach_file("files[]", Rails.root + "spec/fixtures/world.png", visible: false)
      click_link "Metadata" # switch tab
      fill_in('Title', with: 'My Test Work')
      creator_element = find(:css, "input.#{work_label}_creator")
      creator_element.set("Test User")
      description_element = find_by_id("#{work_label}_description")
      description_element.set("Test description")
      fill_in('Required Software', with: "database thingy") if work_class == Dataset
      fill_in('Adviso', with: "Advisor Name") if [Etd, StudentWork].include?(work_class)
      select 'Attribution-ShareAlike 4.0 International', from: "#{work_label}_rights"
      fill_in('Publisher', with: 'tests')
      choose("#{work_label}_visibility_open")
      check('agreement')
      click_on('Save')
      expect(page).to have_content('My Test Work')
      expect(page).to have_content('doi:10.5072/FK2')
    end
  end

  context 'viewing a work' do
    context 'without setting a doi' do
      before { visit polymorphic_path(work_without_doi) }

      it 'does not display the DOI partial on the show page' do
        expect(page).to have_no_content("DOI")
      end
    end

    context 'setting a doi' do
      before { visit polymorphic_path(work_with_doi) }

      it 'displays the DOI partial on the show page' do
        expect(page).to have_css("h2", text: "DOI")
        expect(page).to have_content(work_with_doi.doi)
      end
    end
  end

  context 'editing a work' do
    context 'without a doi' do
      before do
        login_as user
        visit edit_polymorphic_path(work_without_doi)
      end

      it 'displays the request option in the work edit form' do
        click_link "DOI" # switch tab
        expect(page).to have_content("Yes, I would like to create a DOI for this #{work_text}")
      end
    end

    context 'with a doi' do
      before do
        login_as user
        visit edit_polymorphic_path(work_with_doi)
      end

      it 'displays the DOI in the work edit form' do
        click_link "DOI" # switch tab
        expect(page).to have_content(work_with_doi.doi)
      end
    end
  end

  it "displays a warning label if you haven't set a publisher", js: true do
    login_as user
    visit new_polymorphic_path(work_class)
    click_link "DOI" # switch tab
    choose('mint-doi')

    expect(page).to have_css("#publisher-label")
  end

  it "doesn't display a warning label if you have set a publisher", js: true do
    login_as user
    visit new_polymorphic_path(work_class)
    fill_in('Publisher', with: 'tests')
    click_link "DOI" # switch tab
    choose('mint-doi')

    expect(page).to have_no_css("#publisher-label")
  end
end
