class AlbumsController < ApplicationController
  # before_filter :authenticate_user!, only: [:create, :new, :update, :edit, :destroy]
  before_filter :find_user
  before_filter :find_album, only: [:edit, :update, :destroy]
  before_filter :ensure_proper_user, only: [:edit, :new, :create, :update, :destroy]
  # before_filter :add_breadcrumbs


  def index
    @albums = current_user.albums.all

    respond_to do |format|
      format.html 
      format.json { render json: @albums }
    end
  end

  def show
    redirect_to album_pictures_path(params[:id])
  end

  def new
    @album = current_user.albums.new

    respond_to do |format|
      format.html 
      format.json { render json: @album }
    end
  end

  # def edit
  #   add_breadcrumb "Editing Album"
  # end

  def create
    @album = current_user.albums.new(album_params)

    respond_to do |format|
      if @album.save
        current_user.create_activity @album, 'created'
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @album.update_attributes(params[:album])
        current_user.create_activity @album, 'updated'
        format.html { redirect_to album_pictures_path(@album), notice: 'Album was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @album.destroy
    current_user.create_activity @album, 'deleted'
    
    respond_to do |format|
      format.html { redirect_to albums_url }
      format.json { head :no_content }
    end
  end

  def url_options
    { profile_name: params[:profile_name] }.merge(super)
  end

  private

  def album_params
    params.require(:album).permit(:title, :album, :id, :document_attributes, :attachment, :content, :name, :tag_list, :user_id)
    params.require(:album).permit!
  end

  def ensure_proper_user
    if current_user != @user
      flash[:error] = "You don't have permission to do that."
      redirect_to albums_path
    end
  end

  def add_breadcrumbs
    add_breadcrumb @user, profile_path(@user)
    add_breadcrumb "Albums", albums_path
  end

  def find_user
    @user = User.find(current_user.id)
  end

  def find_album
    @album = current_user.albums.find(params[:id])
  end
end
