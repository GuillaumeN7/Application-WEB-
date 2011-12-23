class PersonController < ApplicationController
	
	def index
		@people = Person.all
	end
	
	def create
		@person = Person.new
		@person.name = params[:name]
		@person.firstname = params[:firstname]		
		@person.password = params[:password]
		@person.login = params[:login]	
		if @person.save
			flash[:notice] = "201 USER #{@person.name} #{@person.firstname} alias #{@person.login} CREATED "
		else
			flash[:notice] = "ERROR : possibilities ==> Fill all the fields, Unhautorized or User already existing"
		end	
		redirect_to posts_path
	end
	
	def connect	
		session[:id] = nil
		if request.post?
			person = Person.find_by_login_and_password(params[:login], params[:password])
			if person
 				session[:id]=person.id
 				session[:name]=person.name	
				session[:login]=person.login
				session[:firstname]=person.firstname				
				session[:password]=person.password			
				flash[:notice] = "#{person.login} authenticated"	
				respond_to do |format|
					format.html {redirect_to posts_path} 
					format.js
				end										
			else
				if person = Person.find_by_login(params[:login])
					person = nil
					session[:id]=nil
					flash[:notice] = "Bad Password"
				else
					flash[:notice] = "User not existing"
				end
				respond_to do |format|
					format.html {render :action => "connect"}
					format.js 
				end													
			end					
		end			
	end
	
	def logout
		session[:id] = nil
		session[:name] = nil
		session[:firstname] = nil
		session[:password] = nil
		flash[:notice] = "Deconnexion terminee. Merci de votre visite"
		respond_to do |format|
			format.html {redirect_to posts_path} 
			format.js
		end	
	end
		
end


