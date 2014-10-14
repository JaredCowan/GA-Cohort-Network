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
    @document.build_document

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
    # @document.user_id = current_user.id

    respond_to do |format|
      if @post.save
        current_user.create_activity(@post, 'created')
        format.html { redirect_to :back, notice: 'Post was successfully created.' }
        format.json { render json: @post, post: :created, location: @post }
      else
        format.html { redirect_to :back, notice: "#{@post.errors.count} error(s) prohibited this post from being saved: #{@post.errors.full_messages.join(', ')}  " }
        format.json { render json: @post.errors, post: :unprocessable_entity }
      end
    end
  end


  def update
    if current_user
      @post   = Post.find(params[:id])
      @document = @post.document
    else
      @post   = current_user.posts.find(params[:id])
      @post.document.user_id = current_user.id
      @document = @post.document
    end
      
    if params[:post] && params[:post].has_key?(:user_id)
      params[:post].delete(:user_id) 
    end

    respond_to do |format|
      if @post.update_attributes(post_params)
        format.html { redirect_to :back, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
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
        format.html { redirect_to :back, notice: 'Post was successfully deleted.' }
        format.json { head :no_content }
      else
        format_generic_error("index")
      end
    end
  end

  # def upvote
  #     @post = Post.find(params[:id])
  #     current_user.create_activity(@post, 'liked')
  #     @post.liked_by current_user
  #     redirect_to :back
  # end

  # def downvote
  #     @post = Post.find(params[:id])
  #     @activity = Activity.find_by(targetable_id: @post)
  #     @activity.destroy!
  #     @post.downvote_from current_user
  #     redirect_to :back
  # end

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

  # def set_forum
  #   @post = Post.find(params[:id])
  # end

end
