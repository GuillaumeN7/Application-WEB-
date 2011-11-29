class PersonController < ApplicationController

	def index
	end
	
	def new
	end
	
	def create
		@person = Person.new
		@person.name = params[:name]
		@person.firstname = params[:firstname]		
		@person.password = params[:password]
		@person.login = params[:login]	
		if @person.save
			flash[:notice] = "201 CREATED : l'utilisateur a ete cree avec succes"
		else
			flash[:notice] = "401 (Unauthorized) ou 403 (forbidden) : utilisateur non cree"
		end	
		redirect_to posts_path
	end
		

end


