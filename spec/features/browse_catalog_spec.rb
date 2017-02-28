# frozen_string_literal: true
require 'rails_helper'

describe "Browse catalog:", type: :feature do
  let!(:jills_work) do
    GenericWork.new do |work|
      work.title = ["Jill's Research"]
      (1..25).each do |i|
        work.subject << ["subject#{format('%02d', i)}"]
      end
      work.apply_depositor_metadata('jilluser')
      work.read_groups = ['public']
      work.save!
    end
  end

  let!(:jacks_work) do
    GenericWork.new do |work|
      work.title = ["Jack's Research"]
      work.subject = ['jacks_subject']
      work.apply_depositor_metadata('jackuser')
      work.read_groups = ['public']
      work.save!
    end
  end
end
