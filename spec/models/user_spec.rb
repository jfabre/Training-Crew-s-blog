require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
      :username => ,
      :password => ,
      :site_url => "value for site_url"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
end
