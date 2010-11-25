require 'spec_helper'

describe "/albums/show.html.erb" do
  include AlbumsHelper
  before(:each) do
    assigns[:album] = @album = stub_model(Album,
      :name => "value for name"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
  end
end
