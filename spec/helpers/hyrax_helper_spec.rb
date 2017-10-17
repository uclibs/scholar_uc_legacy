# frozen_string_literal: true
require 'rails_helper'

def new_state
  Blacklight::SearchState.new({}, CatalogController.blacklight_config)
end

describe HyraxHelper, type: :helper do
  describe '#sorted_genre_list_for_documents' do
    it "returns an array" do
      expect(helper.sorted_genre_list_for_documents).to be_an(Array)
    end

    it "contains all the genre types for documents" do
      expect(helper.sorted_genre_list_for_documents).to eq(
        ['Book', 'Book Chapter', 'Brochure', 'Document', 'Letter', 'Manuscript', 'Newsletter', 'Pamphlet', 'Press Release', 'Report', 'White Paper']
      )
    end
  end

  describe '#sorted_genre_list_for_student_works' do
    it "returns an array" do
      expect(helper.sorted_genre_list_for_student_works).to be_an(Array)
    end

    it "contains all the genre types for student works" do
      expect(helper.sorted_genre_list_for_student_works).to eq(
        ['Book', 'Book Chapter', 'Brochure', 'Cartoon/Comic', 'Document', 'Letter', 'Manuscript', 'Map/Chart', 'Newsletter', 'Painting', 'Pamphlet', 'Photograph', 'Poster', 'Press Release', 'Report', 'Visual Art', 'White Paper']
      )
    end
  end

  describe '#sorted_genre_list_for_images' do
    it "returns an array" do
      expect(helper.sorted_genre_list_for_images).to be_an(Array)
    end

    it "contains all the genre types for student works" do
      expect(helper.sorted_genre_list_for_images).to eq(
        ['Cartoon/Comic', 'Map/Chart', 'Painting', 'Photograph', 'Poster', 'Visual Art']
      )
    end
  end

  describe "#sorted_college_list_for_works" do
    let(:etd) { Etd.new }
    let(:student_work) { StudentWork.new }
    let(:other_object) { GenericWork.new }

    it "returns the ETD list if the object is an ETD" do
      expect(helper.sorted_college_list_for_works(etd)).to eq(
        ["", "Allied Health Sciences", "Arts and Sciences", "Business", "College-Conservatory of Music", "Design, Architecture, Art and Planning", "Education, Criminal Justice, and Human Services", "Engineering and Applied Science", "Medicine", "Nursing", "Pharmacy", "Other", "Business Administration", "Education", "Engineering", "Interdisciplinary"]
      )
    end

    it "returns the Student Work list if the object is a Student Work" do
      expect(helper.sorted_college_list_for_works(student_work)).to eq(
        ["", "Allied Health Sciences", "Arts and Sciences", "Blue Ash College", "Business", "Clermont College", "College-Conservatory of Music", "Design, Architecture, Art and Planning", "Education, Criminal Justice, and Human Services", "Engineering and Applied Science", "Law", "Medicine", "Nursing", "Pharmacy", "Other"]
      )
    end

    it "returns the generic list for other classes" do
      expect(helper.sorted_college_list_for_works(other_object)).to eq(
        ["Allied Health Sciences", "Arts and Sciences", "Blue Ash College", "Business", "Clermont College", "College-Conservatory of Music", "Design, Architecture, Art and Planning", "Education, Criminal Justice, and Human Services", "Engineering and Applied Science", "Law", "Libraries", "Medicine", "Nursing", "Pharmacy", "Other"]
      )
    end
  end

  describe "#old_or_new_college" do
    let(:object_with_college_value) { double('object', college: 'COB') }
    let(:object_with_no_college_value) { double('object', college: '') }

    before do
      allow(helper).to receive(:current_user).and_return(
        double('user', college: 'COM')
      )
    end

    it 'uses the preexisting college value if it already exists in the work' do
      expect(helper.old_or_new_college(object_with_college_value)).to eq('COB')
    end

    it 'fills in the college value from user profile if it does not already exist in a work.' do
      expect(helper.old_or_new_college(object_with_no_college_value)).to eq('COM')
    end
  end

  describe "#old_or_new_department" do
    let(:object_with_department_value) { double('object', department: 'Chemistry') }
    let(:object_with_no_department_value) { double('object', department: '') }

    before do
      allow(helper).to receive(:current_user).and_return(
        double('user', department: 'Biology')
      )
    end

    it 'uses the preexisting department value if it already exists in the work' do
      expect(helper.old_or_new_department(object_with_department_value)).to eq('Chemistry')
    end

    it 'fills in the department value from user profile if it does not already exist in a work.' do
      expect(helper.old_or_new_department(object_with_no_department_value)).to eq('Biology')
    end
  end

  describe "#user_college" do
    before do
      allow(helper).to receive(:current_user).and_return(
        double('user', college: "Business")
      )
    end

    let(:etd) { Hyrax::EtdForm.new(Etd.new, nil, controller) }
    let(:student_work) { Hyrax::StudentWorkForm.new(StudentWork.new, nil, controller) }
    let(:other_object) { Hyrax::GenericWorkForm.new(GenericWork.new, nil, controller) }

    it "is blank if the work is an ETD" do
      expect(helper.user_college(etd)).to eq("")
    end

    it "is blank if the work is a Student Work" do
      expect(helper.user_college(student_work)).to eq("")
    end

    it "returns the user college for any other class" do
      expect(helper.user_college(other_object)).to eq("Business")
    end
  end

  describe "#user_department" do
    before do
      allow(helper).to receive(:current_user).and_return(
        double('user', department: "Marketing")
      )
    end

    let(:etd) { Hyrax::EtdForm.new(Etd.new, nil, controller) }
    let(:student_work) { Hyrax::StudentWorkForm.new(StudentWork.new, nil, controller) }
    let(:other_object) { Hyrax::GenericWorkForm.new(GenericWork.new, nil, controller) }

    it "is blank if the work is an ETD" do
      expect(helper.user_department(etd)).to eq("")
    end

    it "is blank if the work is a Student Work" do
      expect(helper.user_department(student_work)).to eq("")
    end

    it "returns the user college for any other class" do
      expect(helper.user_department(other_object)).to eq("Marketing")
    end
  end

  describe "#iconify_auto_link" do
    let(:text)              { 'Foo < http://www.example.com. & More text' }
    let(:linked_text)       { "Foo &lt; <a href=\"http://www.example.com\"><span class=\"glyphicon glyphicon-new-window\"></span> http://www.example.com</a>. &amp; More text" }
    let(:document)          { SolrDocument.new(has_model_ssim: ['GenericWork'], id: 512, title_tesim: text, description_tesim: text) }
    let(:blacklight_config) { CatalogController.blacklight_config }
    before do
      allow(controller).to receive(:action_name).and_return('index')
      allow(helper).to receive(:blacklight_config).and_return(blacklight_config)
    end
    it "boring String argument" do
      expect(helper.iconify_auto_link('no escapes or links necessary')).to eq 'no escapes or links necessary'
      expect(helper.iconify_auto_link('no escapes or links necessary', false)).to eq 'no escapes or links necessary'
    end
    context "interesting String argument" do
      subject { helper.iconify_auto_link(text) }
      it "escapes input" do
        expect(subject).to start_with('Foo &lt;').and end_with('. &amp; More text')
      end
      it "adds links" do
        expect(subject).to include('<a href="http://www.example.com">')
      end
      it "adds icons" do
        expect(subject).to include('class="glyphicon glyphicon-new-window"')
      end
    end

    context "when using a hash argument" do
      subject { helper.iconify_auto_link(arg) }
      describe "auto-linking in the title" do
        let(:arg) { { document: document, value: [text], config: blacklight_config.index_fields['title_tesim'], field: 'title_tesim' } }
        it { is_expected.to eq(linked_text) }
      end

      describe "auto-linking in the description" do
        let(:arg) { { document: document, value: [text], config: blacklight_config.index_fields['description_tesim'], field: 'description_tesim' } }
        it { is_expected.to eq(linked_text) }
      end
    end
  end
end
