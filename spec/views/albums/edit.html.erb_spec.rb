require 'spec_helper'

describe "/albums/edit.html.erb" do
  include AlbumsHelper

  before(:each) do
    assigns[:album] = @album = stub_model(Album,
      :new_record? => false,
      :name => "value for name"
    )
  end

  it "renders the edit album form" do
    render

    response.should have_tag("form[action=#{album_path(@album)}][method=post]") do
      with_tag('input#album_name[name=?]', "album[name]")
    end
  end
end
