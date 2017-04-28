# frozen_string_literal: true
def new_state
  Blacklight::SearchState.new({}, CatalogController.blacklight_config)
end

describe SufiaHelper, type: :helper do
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
end
