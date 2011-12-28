class TagController < ApplicationController
	before_filter :authorize
	def tagPost
		if params[:tag] = 1
			@post = Post.find(params[:id])
			@tag = Tag.new
			@tag.person_id = session[:id]
			@tag.post_id = @post.id
			if @tag.save
				flash[:notice] = "Le post a ete tagge avec succes"
			else
				flash[:notice] = "Le post n'a pas ete tagge"
			end	
		else
			flash[:notice] = "Case non cochee"
		end	
		redirect_to consult_path(@post.id)
	end
	
	def deTagPost
		if params[:tag] = 1	
			@post = Post.find(params[:id])
			@tag = Tag.find_by_post_id_and_person_id(@post.id, session[:id])
			if @tag.destroy
				flash[:notice] = "Le post a ete detagge avec succes"
			else
				flash[:notice] = "Le post n'a pas ete detagge"
			end	
		else
			flash[:notice] = "Case non cochee"
		end			
		redirect_to consult_path(@post.id)
	end

end



