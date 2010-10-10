require 'spec_helper'

describe Category do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :slug => "value for slug"
    }
  end

  it "should create a new instance given valid attributes" do
    Category.create!(@valid_attributes)
  end
end
