class BlogPostsController < ApplicationController
  before_action :set_blog_post, except: [:index, :new, :create]
  before_action :auth_required, except: [:index, :show] 

  def index
    @blog_posts = BlogPost.all
  end

  def show
  end

  def new
    @blog_post = BlogPost.new
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy 
    @blog_post.destroy
    redirect_to root_path
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def blog_post_params
    params.required(:blog_post).permit(:title, :body)
  end

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
  end

  def auth_required 
    redirect_to new_user_session_path, alert:"You must sign in to continue" unless user_signed_in?
  end

end


