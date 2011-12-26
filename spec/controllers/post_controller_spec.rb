require 'spec_helper'
describe PostController do
	describe "GET 'index'" do
		before(:each) do
			@posts = [stub_model(Post,:title => "1"), stub_model(Post, :title => "2")]
			Post.stub(:all){ @posts }
		end
		
		it "assigns a list of posts" do
			Post.should_receive(:all).and_return(@posts)
			get 'index'
			assigns(:posts).should eq @posts
			response.should be_success
		end
		
		it "renders the template list" do
			get 'index'
			response.should render_template(:index)
		end
	end

	describe "DELETE 'delete_path'" do
		before(:each) do
			@person = Person.create(:login => "a", :password =>"b", :name => "c", :firstname => "d")
			session[:id] = @person.id
			@post = Post.create(:person_id => @person.id ,:title => "Titre du Com", :body => "yihaaaa", :id => "4")
			Post.stub(:find){@post}
			@post.stub(:destroy){ true }
		end
		
		it "should destroy and redirect to the posts list" do
			delete :destroy, {:id => @post.id }
			response.should redirect_to posts_path
		end
		
		it "should destroy the post" do
			Post.should_receive(:destroy).with(@post.id.to_s).and_return(@post)
			delete :destroy, {:id => @post.id }
		end					
	end		
	
	describe "POST 'create'" do
		it "should redirect to the todo list" do
			@person = Person.create(:login => "a", :password =>"b", :name => "c", :firstname => "d")
			session[:id] = @person.id
			post :create
			response.should redirect_to posts_path
		end
	 end

	describe "POST 'create'" do
		before(:each) do
			@person = Person.create(:login => "a", :password =>"b", :name => "c", :firstname => "d")
			session[:id] = @person.id
			@new_post_params = {"post" => {"title" => "post_title", "body" => "post_body"}}
			@post = stub_model(Post)
			Post.stub(:new) {@post}
		end

	   it "should create a new Post with the given params" do
			Post.should_receive(:new)
			post :create, @new_post_params
	   end

	   it "should redirect to posts_path" do
			post :create, @new_post_params
			response.should redirect_to posts_path
	  	end
	end
	
	describe " POST 'accessModify' and PUT 'modify'" do
		before(:each) do
			@person = Person.create(:login => "a", :password =>"b", :name => "c", :firstname => "d")
			session[:id] = @person.id		
			@post1 = Post.create(:title => "titre1", :body => "body1")
			@post2 = Post.create(:title => "titre2", :body => "body2")
			@posts = [@post1, @post2]
			Post.stub(:all){ @posts }
			get 'index'
			Post.stub(:find) { @post1 }
		end

		it "Edit post" do
			Post.should_receive(:find).and_return(@postreturn)	
			assigns(@post1).should eq @postreturn			
			post "accessModify", {:id => @post1.id}	
			response.should be_success
			put :modify, {:id => @post1.id}
			response.should redirect_to consult_path(@post1.id)						
		end

	end
	


#TEST CI DESSUS COMMENTE
				# Ici on vérifie qu'on reçoit bien la méthode "find_all_by_post_id" simulé dans le 'before(:each)'
				 # Les éléments trouvés sont alors renvoyés dans '@comments'
#			Comment.should_receive(:find_all_by_post_id).and_return(@comments)
				# On va à la page posts/:@post.id							   
#			get 'read', {:id => @post.id}								
				# On va ici vérifier que la réponse '@comments' (juste même nom que le @comments ci dessus) retournée par le controleur est bien ce qu'on attend, 
				 # en l'occurence '@commentaires' qu'on à crée dans le before.
#			assigns(:commentaires).should eq @comments

	describe "GET 'read'" do
		before(:each) do
			@post = Post.create(:title => "ey", :body => "et encore un petit pour la route!", :id => "31")
				# "Post.stub(:all) { @post }"  <=> "Post.all(params[:id]) (ou @post.id ou @post qui comprend qu'on veut l'id)"
				 # Le stub image la méthode all faite dans le post_controller.rb.
			Post.stub(:all){ @post }	 				
			@comment1 = stub_model(Comment, :author => "Guigui", :body => "aha", :id => 1, :post_id => @post.id)
			@comment2 = stub_model(Comment, :author => "Pibi", :body => "oho", :id => 2, :post_id => @post.id)
			@comment3 = stub_model(Comment, :author => "Oxy", :body => "ihi", :id => 3, :post_id => @post.id)
			@commentaires = [@comment1, @comment2, @comment3]
				# Même principe que ci-dessus sauf qu'on a cette fois dans le controlleur "@comments = Comment.find_all_by_post_id(params[:id])"
				 # Le principe est que l'on simule l'exécution de ces 2 méthodes et on va tester après qu'elles ont fonctionnées.
			Comment.stub(:find_all_by_post_id) {@post.id}									
		end

		it "assigns a list of comment" do
			Comment.should_receive(:find_all_by_post_id).and_return(@comments)
			get 'read', {:id => @post.id}								
			assigns(:commentaires).should eq @comments
			response.should be_success
		end	
	end
	
	describe "POST 'listing'" do
		before(:each) do
			@personA = Person.create(:login => "PersoA", :password =>"b", :name => "c", :firstname => "d")		
			@person = stub_model(Person, :login => "PersoA", :password =>"b", :name => "c", :firstname => "d")
			@person2 = stub_model(Person, :login => "PersoB", :password =>"z", :name => "a", :firstname => "a")			
			@post1 = stub_model(Post, :person_id => @person.id ,:title => "azerty", :body => "yihaaaa", :id => "1")
			@post2 = stub_model(Post, :person_id => @person.id ,:title => "uiop", :body => "poazeza", :id => "2")
			@post3 = stub_model(Post, :person_id => @person.id ,:title => "qsdfgh", :body => "mmmmmm", :id => "3")
			@post4 = stub_model(Post, :person_id => @person2.id ,:title => "poiuio", :body => "gggggg", :id => "1")	 
			@postsAttendus = [@post1, @post2, @post3]
			@postsNonAttendus = [@post1, @post2, @post3, @post4]								

		end
		
		# RESEARCH with SUCCESS
		it "should search the login of @person to verify it existing" do
			@personnetrouvee = Person.stub(:find_by_login){@person}	
			Person.should_receive(:find_by_login).and_return(@personRcv)	
			post :listing, {:auteurSrch => @person.login }
			assigns(:person).should eq @personRcv			
		end
		
		it "should find nothing" do
			post :listing, {:auteurSrch => "", :titreSrch => "", :messSrch => ""}
			response.should redirect_to search_path
			flash.now[:notice].should eq "Aucun parametre renseigne"
		end	

		it "should find something. Params : author" do
			post :listing, {:auteurSrch => @personA.login, :titreSrch => "", :messSrch => ""}
			response.should be_success
			flash.now[:notice].should eq "Resultat de la recherche 'Auteur : #{@personA.login}."
		end				
		
		it "should find something. Params : author and title" do
			post :listing, {:auteurSrch => @personA.login, :titreSrch => @post1.title, :messSrch => ""}
			response.should be_success
			flash.now[:notice].should eq "Resultat de la recherche. 'Auteur : #{@personA.login}. Titre : #{@post1.title}."
		end
		
		it "should find something. Params : author, title and body" do
			post :listing, {:auteurSrch => @personA.login, :titreSrch => @post1.title, :messSrch => @post1.body}
			response.should be_success
			flash.now[:notice].should eq "Resultat de la recherche suivant vos criteres auteur : #{@personA.login}. Titre : #{@post1.title}. Contenant : #{@post1.body}"
		end				
		
		# RESEARCH FAILED and redirect_to search_path because no author
		it "should not find the author searched. Params : author" do
			post :listing, {:auteurSrch => "jeNexistePas", :titreSrch => "", :messSrch => ""}
			response.should redirect_to search_path
			flash.now[:notice].should eq "L'auteur recherche n'existe pas"
		end
		
		it "should not find posts searched. Params : good title and body but bad author" do
			post :listing, {:auteurSrch => "jeNexistePas", :titreSrch => @post1.title, :messSrch => @post1.body}
			response.should redirect_to search_path
			flash.now[:notice].should eq "L'auteur recherche n'existe pas"
		end
		
		# If author exists, response_should be_success but just listing empty
		
		it "should not find following the parameters specified => good author bad title" do
			post :listing, {:auteurSrch => @personA.login, :titreSrch => "TitreQuiExistePas", :messSrch => ""}
			response.should be_success
			flash.now[:notice].should eq "Resultat de la recherche. 'Auteur : #{@personA.login}. Titre : TitreQuiExistePas."
		end
		
		it "should not find following the parameters specified => good author and bad body" do
			post :listing, {:auteurSrch => @personA.login, :titreSrch => "", :messSrch => "MessQuiExistePas"}
			response.should be_success
			flash.now[:notice].should eq "Resultat de la recherche 'Auteur : #{@personA.login}. Contenant : MessQuiExistePas"
		end	
		
		it "should not find following the parameters specified => no author and bad body" do
			post :listing, {:auteurSrch => "", :titreSrch => "", :messSrch => "QueLeMessFaux"}
			response.should be_success
			flash.now[:notice].should eq "Resultat de la recherche 'Contenant : QueLeMessFaux"
		end		
		
		it "should not find following the parameters specified => no author and bad title" do
			post :listing, {:auteurSrch => "", :titreSrch => "QueLeTitreFaux", :messSrch => ""}
			response.should be_success
			flash.now[:notice].should eq "Resultat de la recherche 'Titre : QueLeTitreFaux"
		end		
		
		it "should not find following the parameters specified => no author, bad title and bad body" do
			post :listing, {:auteurSrch => "", :titreSrch => "QueLeTitreFaux", :messSrch => "fauxnoexisting"}
			response.should be_success
			flash.now[:notice].should eq "Resultat de la recherche 'Titre : QueLeTitreFaux. Message : fauxnoexisting"
		end			
				
	end		
end


















