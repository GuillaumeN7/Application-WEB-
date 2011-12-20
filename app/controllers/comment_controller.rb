class CommentController < ApplicationController
	before_filter :authorize, :except => [:new, :create]
		
	def new
	    @post = Post.find(params[:id])
	end

	def create
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
	
	def edit
		@post = Post.find(params[:id])
   		@comment = @post.comments.find(params[:comment_id])
	end
	
	def modify
		@post = Post.find(params[:id])
   		@comment = @post.comments.find(params[:comment_id])
   		@comment.author = params[:author]
		@comment.body = params[:body]
		if @comment.save
			flash[:notice] = "200 : Commentaire modifie avec succes"
		else
			flash[:notice] = "401 (Unauthorized) ou 403 (forbidden) : Echec de la modification"
		end
		redirect_to consult_path(@post.id)
	end	
	
	def destroy
		@post = Post.find(params[:id])
		@comment = @post.comments.find(params[:comment_id])
		@author = @comment.author
		if Comment.destroy(params[:comment_id])
			flash[:notice] = "200 : Le commentaire de #{@author} a ete supprime avec succes"
		else
			flash[:notice] = "304 : Le commentaire de #{@author} n'a pagcaens ete supprime"
		end
		redirect_to consult_path(params[:id])
	end
		
	
	
end


