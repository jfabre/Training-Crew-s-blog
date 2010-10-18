require 'spec_helper'

describe VideosController do

  def mock_video(stubs={})
    @mock_video ||= mock_model(Video, stubs)
  end

  describe "GET index" do
    it "assigns all videos as @videos" do
      Video.stub(:find).with(:all).and_return([mock_video])
      get :index
      assigns[:videos].should == [mock_video]
    end
  end

  describe "GET show" do
    it "assigns the requested video as @video" do
      Video.stub(:find).with("37").and_return(mock_video)
      get :show, :id => "37"
      assigns[:video].should equal(mock_video)
    end
  end

  describe "GET new" do
    it "assigns a new video as @video" do
      Video.stub(:new).and_return(mock_video)
      get :new
      assigns[:video].should equal(mock_video)
    end
  end

  describe "GET edit" do
    it "assigns the requested video as @video" do
      Video.stub(:find).with("37").and_return(mock_video)
      get :edit, :id => "37"
      assigns[:video].should equal(mock_video)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created video as @video" do
        Video.stub(:new).with({'these' => 'params'}).and_return(mock_video(:save => true))
        post :create, :video => {:these => 'params'}
        assigns[:video].should equal(mock_video)
      end

      it "redirects to the created video" do
        Video.stub(:new).and_return(mock_video(:save => true))
        post :create, :video => {}
        response.should redirect_to(video_url(mock_video))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved video as @video" do
        Video.stub(:new).with({'these' => 'params'}).and_return(mock_video(:save => false))
        post :create, :video => {:these => 'params'}
        assigns[:video].should equal(mock_video)
      end

      it "re-renders the 'new' template" do
        Video.stub(:new).and_return(mock_video(:save => false))
        post :create, :video => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested video" do
        Video.should_receive(:find).with("37").and_return(mock_video)
        mock_video.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :video => {:these => 'params'}
      end

      it "assigns the requested video as @video" do
        Video.stub(:find).and_return(mock_video(:update_attributes => true))
        put :update, :id => "1"
        assigns[:video].should equal(mock_video)
      end

      it "redirects to the video" do
        Video.stub(:find).and_return(mock_video(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(video_url(mock_video))
      end
    end

    describe "with invalid params" do
      it "updates the requested video" do
        Video.should_receive(:find).with("37").and_return(mock_video)
        mock_video.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :video => {:these => 'params'}
      end

      it "assigns the video as @video" do
        Video.stub(:find).and_return(mock_video(:update_attributes => false))
        put :update, :id => "1"
        assigns[:video].should equal(mock_video)
      end

      it "re-renders the 'edit' template" do
        Video.stub(:find).and_return(mock_video(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested video" do
      Video.should_receive(:find).with("37").and_return(mock_video)
      mock_video.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the videos list" do
      Video.stub(:find).and_return(mock_video(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(videos_url)
    end
  end

end
