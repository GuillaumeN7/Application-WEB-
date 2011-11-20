class PersonController < ApplicationController

	def newUser
	end
	
	def createUser
		@person = Person.new
		@person.name = params[:name]
		@person.firstname = params[:firstname]		
		@person.password = params[:password]
		@person.login = params[:login]	
		@person.save
		redirect_to posts_path
	end
		

end


