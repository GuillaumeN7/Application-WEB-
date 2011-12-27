class PostController < ApplicationController
	before_filter :authorize, :except => [:read, :index, :search, :makeSearch, :listing]

	def index
		@posts = Post.all	
	end
	
	def search
	
	end
	
	def listing
		# les 3 parametres renseignes par l'user
		if params[:auteurSrch] != "" and params[:titreSrch] != "" and params[:messSrch] != ""
			# On verifie que l'user recherche existe pour ne pas avoir un 'Nil_Object'
			if Person.find_by_login(params[:auteurSrch])
				@posts = Post.find(:all, :conditions => ["person_id = #{Person.find_by_login(params[:auteurSrch]).id} AND title = '#{params[:titreSrch]}' AND body like ?", "%#{params[:messSrch]}%"])
#				@posts = Post.find_all_by_person_id_and_title_and_body(Person.find_by_login(params[:auteurSrch]).id, params[:titreSrch], params[:messSrch])
				flash[:notice] = "Resultat de la recherche suivant vos criteres auteur : #{params[:auteurSrch]}. Titre : #{params[:titreSrch]}. Contenant : #{params[:messSrch]}"									
			# User non existant => pas de resultat possible	
			else
				flash[:notice] = "L'auteur recherche n'existe pas"
				redirect_to search_path
			end
		# parametres renseignes par l'user dont le titre
		elsif params[:titreSrch] != ""
			# titre + auteur
			if params[:auteurSrch] != ""
				if Person.find_by_login(params[:auteurSrch])
					@posts = Post.find_all_by_person_id_and_title(Person.find_by_login(params[:auteurSrch]).id, params[:titreSrch])		
					flash[:notice] = "Resultat de la recherche. 'Auteur : #{params[:auteurSrch]}. Titre : #{params[:titreSrch]}."	
				else
					flash[:notice] = "L'auteur recherche n'existe pas"
					redirect_to search_path
				end
			
			# titre + message
			elsif params[:messSrch] != ""
				@posts = Post.find(:all, :conditions => ["title = '#{params[:titreSrch]}' AND body like ?", "%#{params[:messSrch]}%"])			
#				@posts = Post.find_all_by_title_and_body(params[:titreSrch], params[:messSrch])
				flash[:notice] = "Resultat de la recherche 'Titre : #{params[:titreSrch]}. Message : #{params[:messSrch]}"				
			
			#titre uniquement
			else 
				@posts = Post.find_all_by_title(params[:titreSrch])
				flash[:notice] = "Resultat de la recherche 'Titre : #{params[:titreSrch]}"
			end
			
		# 2 parametres renseignes par l'user dont l'auteur
		elsif params[:auteurSrch] != ""
			if Person.find_by_login(params[:auteurSrch])
			
				# auteur + message
				if params[:messSrch] != ""
					@posts = Post.find(:all, :conditions => ["person_id = #{Person.find_by_login(params[:auteurSrch]).id} AND body like ?", "%#{params[:messSrch]}%"])
#					@posts = Post.find_all_by_person_id_and_body(Person.find_by_login(params[:auteurSrch]).id, params[:messSrch])
					flash[:notice] = "Resultat de la recherche 'Auteur : #{params[:auteurSrch]}. Contenant : #{params[:messSrch]}"		
			
				# auteur uniquement
				else 
					@posts = Post.find_all_by_person_id(Person.find_by_login(params[:auteurSrch]).id)
					flash[:notice] = "Resultat de la recherche 'Auteur : #{params[:auteurSrch]}."
				end	
			else
				flash[:notice] = "L'auteur recherche n'existe pas"
				redirect_to search_path
			end
		
		# Recherche par 'body' du post uniquement 
		elsif params[:messSrch] != ""
#			@posts = Post.find_all_by_body(params[:messSrch])
			@posts = Post.find(:all, :conditions => ["body like ?", "%#{params[:messSrch]}%"])
			flash[:notice] = "Resultat de la recherche 'Contenant : #{params[:messSrch]}"		
		
		# Aucun parametres renseignes
		else
			flash[:notice] = "Aucun parametre renseigne"
			redirect_to search_path
		end
			
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
			flash[:notice] = "error (title or body) : #{@post.errors[:title]}#{@post.errors[:body]} --> post not created"
		end	  
		redirect_to posts_path
	end

	def destroy
		@posts = Post.all	
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


