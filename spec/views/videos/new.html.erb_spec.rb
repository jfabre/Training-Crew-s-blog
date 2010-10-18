require 'spec_helper'

describe "/videos/new.html.erb" do
  include VideosHelper

  before(:each) do
    assigns[:video] = stub_model(Video,
      :new_record? => true,
      :name => "value for name",
      :url => "value for url",
      :description => "value for description"
    )
  end

  it "renders new video form" do
    render

    response.should have_tag("form[action=?][method=post]", videos_path) do
      with_tag("input#video_name[name=?]", "video[name]")
      with_tag("input#video_url[name=?]", "video[url]")
      with_tag("textarea#video_description[name=?]", "video[description]")
    end
  end
end
