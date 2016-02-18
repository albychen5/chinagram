class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!

	def index
		@posts = Post.all
	end

	def show
	end

	def new
		@post = Post.new
	end

	def create
		if @post = Post.create(post_params)
			flash[:success] = "Your post has been created!"
			redirect_to posts_path
		else
			flash.now[:alert] = "Your new post couldn't be created! Check the form."
			render :new
		end
	end

	def edit
	end

	def update
		if @post.update(post_params)
			flash[:success] = "Your post has been updated!"
			redirect_to (post_path(@post))
		else
			flash.now[:alert] = "Your post couldn't be updated! Check the form."
			render :edit
		end
	end

	def destroy
		@post.destroy
		redirect_to (posts_path)
		flash[:success] = "Your post has been deleted!"
	end

	private
	def post_params
		params.require(:post).permit(:image, :caption)
	end

	def set_post
		@post = Post.find(params[:id])
	end
end