class ApplicationController < ActionController::Base
#	protect_from_forgery
	private
	# On aura une double securite. Un utilisateur non logge ne verra pas les boutons d'actions dans un premier temps (caches par le html).
	# Et s'il peut envoyer des requêtes au serveur sans passer par l'interface graphique il sera rejete grâce à la methode suivante.
	def authorize
	  	unless Person.find_by_id(session[:id])
	  		flash[:notice] = "Il est necessaire d'etre connecte pour effectuer cette action"
	  		redirect_to posts_path
		end
	end
end
