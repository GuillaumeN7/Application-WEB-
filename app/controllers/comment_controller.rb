class CommentController < ApplicationController

	def index
		post = Post.find(params[:id])		
		@comments = Comment.find_all_by_post_id(params[:id])
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
	
	def read
		post = Post.find(params[:id])
#   		@comment = post.comments.find(params[:comment_id])
	end
	
	def destroy
		comment = Comment.find(params[:comment_id])
		@author = comment.author
		if Comment.delete(params[:comment_id])
			flash[:notice] = "200 : Le commentaire de #{@author} a ete supprime avec succes"
		else
			flash[:notice] = "304 : Le commentaire de #{@author} n'a pas ete supprime"
		end
		redirect_to consult_path(params[:id])
	end
		
	
	
end


