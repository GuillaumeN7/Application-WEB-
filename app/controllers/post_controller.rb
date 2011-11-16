class PostController < ApplicationController
  def index
		@posts = Post.all
  end

	def new
	end
	
	def create
		@post = Post.new
		@post.title = params[:title]
		@post.body = params[:body]		
		@post.save
		redirect_to posts_path
	end

	def destroy
		Post.delete(params[:id])
		redirect_to posts_path
	end
	
	def read
		@post = Post.find(params[:id])
	end
	

end


