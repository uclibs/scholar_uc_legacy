require 'spec_helper'

describe Article do
  it "has a valid Article factory" do
    expect(build(:article)).to be_valid
  end
end

describe Dataset do
  it "has a valid Dataset factory" do
    expect(build(:dataset)).to be_valid
  end
end

describe Document do
  it "has a valid Document factory" do
    expect(build(:document)).to be_valid
  end
end

describe GenericWork do
  it "has a valid GenericWork factory" do
    expect(build(:generic_work)).to be_valid
  end
end

describe Image do
  it "has a valid Image factory" do
    expect(build(:image)).to be_valid
  end
end
