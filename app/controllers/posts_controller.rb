class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
	before_action :owned_post, only: [:edit, :update, :destroy]

	def index
		@posts = Post.all.order('created_at DESC').page params[:page]
	end

	def show
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)
		
		if @post.save
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

	def owned_post
		unless current_user == @post.user
			flash[:alert] = "That's not your post"
			redirect_to root_path
		end
	end

end