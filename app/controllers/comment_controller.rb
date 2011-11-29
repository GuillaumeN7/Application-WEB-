class CommentController < ApplicationController

	def index
	    post = Post.find(params[:id])
    	#Get comments of post
    	@comments = post.comments
	end
	
	def create
	    post = Post.find(params[:id])
	end
	
	def new
	    post = Post.find(params[:id])
	    @comment = post.comments.build	
		@comment.author = params[:author]
		@comment.body = params[:body]		
		@comment.post_id = params[:id]			
		if @comment.save
			flash[:notice] = "201 CREATED : Commentaire ajoute avec succes"
		else
			flash[:notice] = "401 (Unauthorized) ou 403 (forbidden) : commentaire non ajoute"
		end	
		redirect_to consult_path
	end
	
	def show
	    post = Post.find(params[:id])
    	@comment = post.comments.find(params[:comment_id])
	end
	
	
end


