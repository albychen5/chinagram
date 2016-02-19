class CommentsController < ApplicationController

	def create
		@comment = current_user.posts.comment.build(comment_params)

		if @comment.save
			//
		else
			//
		end
	end

	private
	def comment_params

	end
end
