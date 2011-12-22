class PostController < ApplicationController
	before_filter :authorize, :except => [:read, :index]

	def index
		@posts = Post.all
	end

	def new
	end

	def create
		@post = Post.new
		@post.title = params[:title]
		@post.body = params[:body]
		if session[:id]
			@post.person_id = session[:id]
		end		
		if @post.save
			flash[:notice] = "201 CREATED : post created with success"
		else
			@post.valid?	
			@post.errors
			@post.errors
			flash[:notice] = "error : #{@post.errors[:title]} --> post not created"
		end	  
		redirect_to posts_path
	end

	def destroy
		@post = Post.find(params[:id])
		if @post.person_id != session[:id]	
			flash[:notice] = "ERROR : Ce post ne vous appartient pas!"	
		else	if 
			Post.destroy(params[:id])
				flash[:notice] = "200 : Le post a ete supprime avec succes"
			else
				flash[:notice] = "304 : erreur, post non supprime"
			end						
		end
#		redirect_to posts_path
		respond_to do |format|
			format.html {redirect_to posts_path} 
			format.js
		end		
	end

	def read
		@post = Post.find(params[:id])
		@comments = Comment.find_all_by_post_id(params[:id])
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


