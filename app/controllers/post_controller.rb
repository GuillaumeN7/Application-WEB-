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
		if @post.save
		      flash[:notice] = "201 CREATED : Le post a ete cree avec succes"
		else
			  flash[:notice] = "401 (Unauthorized) ou 403 (forbidden) : Le post n'a pas ete cree"
		end	  
		redirect_to posts_path
	end

	def destroy
		Post.delete(params[:id])
		flash[:notice] = "200 : Le post a ete supprime avec succes"
		redirect_to posts_path
	end
	
	def read
		@post = Post.find(params[:id])
		@comments = Comment.all
	end
	
	def accessModify
		@post = Post.find(params[:id])
	end
	
	def modify
		@post = Post.find(params[:id])
		@post.title = params[:title]
		@post.body = params[:body]
		if @post.save
			flash[:notice] = "200 : Post modifie avec succes"
		else
			flash[:notice] = "401 (Unauthorized) ou 403 (forbidden) : Echec de la modification"
		end
		redirect_to consult_path
	end

end


