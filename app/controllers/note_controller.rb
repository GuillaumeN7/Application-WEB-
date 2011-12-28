class NoteController < ApplicationController
	before_filter :authorize

	def saveNote
		@post = Post.find(params[:id])
		@note = Note.new
		@note.person_id = session[:id]
		@note.post_id = @post.id
		@note.note = params[:note]
		
		if @note.save
			@notes = Note.find(:all, :conditions => ["post_id like ?", "#{@post.id}"])		
			@n = 0
			@notes.each do |n|
 				@n += n.note
			end
			@post.note_post =  @n / @notes.count		
			@post.save
			flash[:notice] = "Merci, votre avis a bien ete pris en compte."
		else
			@note.valid?	
			@note.errors
			flash[:notice] = "erreur : vote non retenu"
		end	
		redirect_to consult_path(params[:id])	
	end

end





