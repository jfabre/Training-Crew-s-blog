require 'spec_helper'

describe "/videos/index.html.erb" do
  include VideosHelper

  before(:each) do
    assigns[:videos] = [
      stub_model(Video,
        :name => "value for name",
        :url => "value for url",
        :description => "value for description"
      ),
      stub_model(Video,
        :name => "value for name",
        :url => "value for url",
        :description => "value for description"
      )
    ]
  end

  it "renders a list of videos" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for url".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
  end
end
