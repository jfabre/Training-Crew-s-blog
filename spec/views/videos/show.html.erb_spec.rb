require 'spec_helper'

describe "/videos/show.html.erb" do
  include VideosHelper
  before(:each) do
    assigns[:video] = @video = stub_model(Video,
      :name => "value for name",
      :url => "value for url",
      :description => "value for description"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ url/)
    response.should have_text(/value\ for\ description/)
  end
end
