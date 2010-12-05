class AlbumsController < ApplicationController
  layout 'master'
  # GET /albums
  # GET /albums.xml
  def index
    @albums = Album.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.xml
  def show
    @album = Album.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/new
  # GET /albums/new.xml
  def new
    @album = Album.new
    @images = Image.all(:conditions => {:album_id => nil})
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @images = Image.all(:conditions => {:album_id => nil})
    @album = Album.find(params[:id])
  end

  # POST /albums
  # POST /albums.xml
  def create
    @album = Album.new(params[:album])
    
    respond_to do |format|
      @album.images << Image.find([params[:images]].flatten)
      
      if @album.save
        format.html { redirect_to(albums_path, :notice => 'Album was successfully created.') }
        format.xml  { render :xml => albums_path, :status => :created, :location => @album }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.xml
  def update
    @album = Album.find(params[:id])
    
    respond_to do |format|
      if @album.update_attributes(params[:album])
        @album.images.clear
        @album.images << Image.find([params[:images]].flatten)
        @album.save!
        format.html { redirect_to(albums_path, :notice => 'Album was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.xml
  def destroy
    @album = Album.find(params[:id])
    @album.images.clear
    @album.save
    @album.destroy
    Image.all(:conditions => {:album_id => params[:id]}).each do |x| 
      x.album_id = nil
      x.save
    end
    respond_to do |format|
      format.html { redirect_to(albums_url) }
      format.xml  { head :ok }
    end
  end
  
  def display
    unless params[:id].nil?
      @albums = [Album.find(params[:id])]
    else
      @albums = Album.paginate(:page => params[:page], :order => 'created_at DESC', :per_page => 1)
    end
  end
end
