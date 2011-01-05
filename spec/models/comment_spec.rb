#require 'spec_helper'

describe Comment do
  before(:each) do
    @valid_attributes = {
      :user => "value for user",
      :website => "value for website",
      :text => "value for text"
    }
  end

  it "should create a new instance given valid attributes" do
    Comment.create!(@valid_attributes)
  end
end
