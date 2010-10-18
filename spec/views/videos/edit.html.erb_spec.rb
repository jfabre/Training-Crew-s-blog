require 'spec_helper'

describe "/videos/edit.html.erb" do
  include VideosHelper

  before(:each) do
    assigns[:video] = @video = stub_model(Video,
      :new_record? => false,
      :name => "value for name",
      :url => "value for url",
      :description => "value for description"
    )
  end

  it "renders the edit video form" do
    render

    response.should have_tag("form[action=#{video_path(@video)}][method=post]") do
      with_tag('input#video_name[name=?]', "video[name]")
      with_tag('input#video_url[name=?]', "video[url]")
      with_tag('textarea#video_description[name=?]', "video[description]")
    end
  end
end
