class PostsController < ApplicationController
  before_action :signed_in_user
  respond_to :html, :json

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new

    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  def edit
    @post = Post.find(params[:id])
    @post = current_user.posts.find(params[:id])
  end

  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        puts @post.inspect
        current_user.create_activity(@post, 'created')
        format.html { redirect_to :back }
        format.json { render json: @post, post: :created, location: @post }
        flash[:success] = "Post was successfully created."
      else
        format.html { redirect_to :back, notice: "#{@post.errors.count} error(s) prohibited this post from being saved: #{@post.errors.full_messages.join(', ')}  " }
        format.json { render json: @post.errors, post: :unprocessable_entity }
      end
    end
  end


  def update
    if current_user
      @post     = Post.find(params[:id])
      @document = @post.document
    else
      @post     = current_user.posts.find(params[:id])
      @post.document.user_id = current_user.id
      @document = @post.document
    end

    respond_to do |format|
      if @post.update_attributes(post_params)
        format.html { redirect_to :back }
        format.json { head :no_content }
        flash[:success] = "Post was successfully updated."
      else
        redirect_to :back
        # format_generic_error("edit")
      end
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])

    respond_to do |format|
      if @post.destroy
        format.html { redirect_to :back }
        format.json { head :no_content }
        flash[:success] = "Post was successfully deleted."
      else
        format_generic_error("index")
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :friend_id, :id, :document_attributes, :attachment)
    params.require(:post).permit!
  end

  def format_generic_error(type)
    redirect_to :back
    format.html { redirect_to :back }
    format.json { render json: @post.errors, post: :unprocessable_entity }
  end
end # End controller