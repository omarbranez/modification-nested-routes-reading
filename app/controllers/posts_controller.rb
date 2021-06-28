class PostsController < ApplicationController

  def index
    if params[:author_id]
      @posts = Author.find(params[:author_id]).posts
    else
      @posts = Post.all
    end
  end

  def show
    if params[:author_id]
      @post = Author.find(params[:author_id]).posts.find(params[:id])
    else
      @post = Post.find(params[:id])
    end
  end

  def new
    if params[:author_id] && !Author.exists?(params[:author_id])
      redirect_to authors_path, alert: "Author not found" # check to see if author exists
      # THIS NESTED ROUTE SHIT IS A LOT MORE TROUBLE THAN ITS WORTH
      # theres totally a helper for this isnt there
    else
      @post = Post.new(author_id: params[:author_id]) # handle the new author parameter
    end
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def edit
    # @post = Post.find(params[:id]) # allows anyone to edit an author's posts
    if params[:author_id]
      author = Author.find_by(id: params[:author_id])
      if author.nil?
        redirect_to authors_path, alert: "Author not found"
      else
        @post = author.posts.find_by(id: params[:id])
        redirect_to author_posts_path(author), alert: "Post not found" if @post.nil?
      end
    else
      @post = Post.find(params[:id])
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :author_id) # allow author_id into strong params
  end
end
