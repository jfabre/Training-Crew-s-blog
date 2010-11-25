require 'spec_helper'

describe "/albums/index.html.erb" do
  include AlbumsHelper

  before(:each) do
    assigns[:albums] = [
      stub_model(Album,
        :name => "value for name"
      ),
      stub_model(Album,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of albums" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
