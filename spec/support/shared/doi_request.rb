# frozen_string_literal: true

shared_examples 'doi request' do |work_class|
  let(:user) { create(:user) }
  let!(:role1) { Sipity::Role.create(name: 'depositing') }
  let(:work_without_doi) do
    create(work_class.to_s.underscore.to_sym,
           title: ["Magnificent splendor"],
           alt_description: "My description",
           source: ["The Internet"],
           based_near: ["USA"],
           visibility: "open",
           user: user)
  end

  let(:work_with_minted_doi) do
    create(work_class.to_s.underscore.to_sym,
           title: ["Magnificent splendor"],
           alt_description: "My description",
           source: ["The Internet"],
           based_near: ["USA"],
           doi: "doi:1234foo",
           identifier_url: "http://example.org/id/doi:1234foo",
           existing_identifier: "",
           visibility: "open",
           user: user)
  end

  let(:work_with_manual_doi) do
    create(work_class.to_s.underscore.to_sym,
           title: ["Magnificent splendor"],
           creator: ["Test User"],
           rights: ["http://creativecommons.org/publicdomain/mark/1.0/"],
           alt_description: "My description",
           source: ["The Internet"],
           based_near: ["USA"],
           doi: "doi:1234foo",
           identifier_url: nil,
           existing_identifier: "doi:1234foo",
           visibility: "open",
           user: user)
  end

  let(:work_label) { work_class.name.underscore }

  before do
    allow_any_instance_of(Ability).to receive(:user_is_etd_manager).and_return(true)
    page.driver.browser.js_errors = false
    allow(CharacterizeJob).to receive(:perform_later)
  end

  context 'creating a work' do
    before do
      login_as user
      visit new_polymorphic_path(work_class)
    end

    it 'displays the request option in the work edit form' do
      click_link "DOI" # switch tab
      expect(page).to have_content "Yes, I would like to create a DOI"
      expect(page).to have_content "Not now…but maybe later."
    end

    it 'mints a DOI for the work' do
      page.current_window.resize_to(5000, 5000)
      click_link "DOI" # switch tab
      choose('mint-doi')
      click_link "Files" # switch tab
      attach_file("files[]", Rails.root + "spec/fixtures/world.png", visible: false)
      click_link "Metadata" # switch tab
      title_element = find_by_id("#{work_label}_title")
      title_element.set("My Test Work")
      creator_element = find(:css, "input.#{work_label}_creator")
      creator_element.set("Test User")
      description_element = find_by_id("#{work_label}_alt_description")
      description_element.set("Test description")
      fill_in('Required Software', with: "database thingy") if work_class == Dataset
      college_element = find_by_id("#{work_label}_college")
      college_element.select("Business")
      department_element = find_by_id("#{work_label}_department")
      department_element.set("Marketing")
      fill_in('Advisor', with: "Advisor Name") if [Etd, StudentWork].include?(work_class)
      select 'Attribution-ShareAlike 4.0 International', from: "#{work_label}_rights"
      fill_in('Publisher', with: 'tests')
      choose("#{work_label}_visibility_open")
      check('agreement')
      click_on('Save')
      expect(page).to have_content('My Test Work')
      expect(page).to have_content('doi:10.5072/FK2')
    end
  end

  context 'creating a work with private visibility' do
    before do
      login_as user
      visit new_polymorphic_path(work_class)
    end

    it 'displays the request option in the work edit form' do
      click_link "DOI" # switch tab
      expect(page).to have_content "Yes, I would like to create a DOI"
      expect(page).to have_content "Not now…but maybe later."
    end

    it 'mints a DOI for the work and the work can be edited' do
      page.current_window.resize_to(5000, 5000)
      click_link "DOI" # switch tab
      choose('mint-doi')
      click_link "Files" # switch tab
      attach_file("files[]", Rails.root + "spec/fixtures/world.png", visible: false)
      click_link "Metadata" # switch tab
      title_element = find_by_id("#{work_label}_title")
      title_element.set("My Test Work")
      creator_element = find(:css, "input.#{work_label}_creator")
      creator_element.set("Test User")
      description_element = find_by_id("#{work_label}_alt_description")
      description_element.set("Test description")
      fill_in('Required Software', with: "database thingy") if work_class == Dataset
      college_element = find_by_id("#{work_label}_college")
      college_element.select("Business")
      department_element = find_by_id("#{work_label}_department")
      department_element.set("Marketing")
      fill_in('Advisor', with: "Advisor Name") if [Etd, StudentWork].include?(work_class)
      select 'Attribution-ShareAlike 4.0 International', from: "#{work_label}_rights"
      fill_in('Publisher', with: 'tests')
      choose("#{work_label}_visibility_restricted")
      check('agreement')
      click_on('Save')
      expect(page).to have_content('My Test Work')
      expect(page).to have_content('doi:10.5072/FK2')

      click_link "Edit"
      title_element = find_by_id("#{work_label}_title")
      title_element.set("My Test Work 2")
      click_on('Save')
      expect(page).to have_content('My Test Work 2')
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
      before { visit polymorphic_path(work_with_minted_doi) }

      it 'displays the DOI partial on the show page' do
        expect(page).to have_css("h2", text: "DOI")
        expect(page).to have_content(work_with_minted_doi.doi)
      end
    end
  end

  context 'editing a work' do
    it "displays a warning label if you haven't set a publisher", js: true do
      login_as user
      visit new_polymorphic_path(work_class)
      fill_in('Publisher', with: '')
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

    context 'without a doi' do
      before do
        login_as user
        visit edit_polymorphic_path(work_without_doi)
      end

      it 'displays the request option in the work edit form' do
        click_link "DOI" # switch tab
        expect(page).to have_content("Yes, I would like to create a DOI")
        expect(page).to have_checked_field(id: "not-now")
      end
    end

    context 'with a minted doi' do
      before do
        login_as user
        visit edit_polymorphic_path(work_with_minted_doi)
      end

      it 'displays the DOI in the work edit form' do
        click_link "DOI" # switch tab
        expect(page).to have_content(work_with_minted_doi.doi)
      end
    end

    context 'with a manually entered DOI' do
      before do
        login_as user
        visit edit_polymorphic_path(work_with_manual_doi)
        if [Etd, StudentWork].include?(work_class)
          fill_in('Advisor', with: "Advisor Name")
          college_element = find_by_id("#{work_label}_college")
          college_element.select("Business")
          department_element = find_by_id("#{work_label}_department")
          department_element.set("Marketing")
        end
        click_link "DOI" # switch tab
      end

      it 'displays the DOI edit form, with the manually entered DOI' do
        expect(page).to have_content("Yes, I would like to create a DOI")
        expect(page).to have_field(id: "#{work_label}_existing_identifier", with: work_with_manual_doi.doi)
        expect(page).to have_checked_field(id: "no-doi")
      end

      context 'when changing the entered DOI' do
        context 'to another DOI' do
          let(:new_doi) { "doi:foo12345" }
          it 'has the new DOI on the view page' do
            fill_in(id: "#{work_label}_existing_identifier", with: new_doi)
            click_on('Save')
            expect(page).to have_css("h2", text: "DOI")
            expect(page).to have_content(new_doi)
          end
        end

        context 'to a blank DOI' do
          it 'has no DOI on the view page' do
            fill_in(id: "#{work_label}_existing_identifier", with: "")
            click_on('Save')
            expect(page).to have_no_content("DOI")
          end
        end
      end

      context 'when selecting not to have a DOI' do
        it 'has no DOI on the view page' do
          choose(id: 'not-now')
          click_on('Save')
          expect(page).to have_no_content("DOI")
        end
      end
    end
  end
end
