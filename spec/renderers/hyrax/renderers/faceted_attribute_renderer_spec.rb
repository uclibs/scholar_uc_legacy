# frozen_string_literal: true
require 'rails_helper'

describe Hyrax::Renderers::FacetedAttributeRenderer do
  let(:field) { :department }
  let(:renderer) { described_class.new(field, ['libraries & archives']) }

  describe "#attribute_to_html" do
    subject { Nokogiri::HTML(renderer.render) }
    let(:expected) { Nokogiri::HTML(tr_content) }
    let(:tr_content) do
      %(
      <tr><th>Department</th>
      <td><ul class='tabular'>
      <li class="attribute department"><a href="/catalog?f%5Bdepartment_sim%5D%5B%5D=libraries+%26+archives">libraries & archives</a></li>
      </ul></td></tr>
    )
    end

    it { expect(subject).to be_equivalent_to(expected) }
  end
end
