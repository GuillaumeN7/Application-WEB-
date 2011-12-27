require 'spec_helper'

#-------------------------------------------User not logged--------------------------------------------------
describe "post/index.html.erb" do
	before(:each) do	
		@person1 = Person.create(:name => "a", :firstname => "aa", :login => "capybara", :password => "aaAzeaz")
		@person2 = Person.create(:name => "a", :firstname => "aa", :login => "capybara2222", :password => "aaAzeaz")			
		@post1 = stub_model(Post, :person_id => @person1, :title => "sujet1", :updated_at => "2011-10-23 12:17:47")
		@post2 = stub_model(Post, :person_id => @person2, :title => "sujet2", :updated_at => "2011-11-18 19:01:00")
		@post3 = stub_model(Post, :person_id => @person2, :title => "sujet3", :updated_at => DateTime.now)		
		@posts = [@post1, @post2]
		@posts_bis = [@post3]			
		render
	end	

	it "display number of post and title" do
		rendered.should =~ /sujet1/
		rendered.should =~ /#{@post1.title}/
		rendered.should =~ /sujet2/				
		rendered.should =~ /#{@post2.title}/
	end

    	it "should not have a button named 'Add New Post' for create a post" do
		rendered.should have_selector("input", :type => "submit", :name => "Add New Post", :href => posts_new_path) 
		rendered.should_not have_button("Add New Post")
	end
	
	it "display 'Affichage des posts', not display'Creation des posts' and 'Nouveau Post :'" do
		rendered.should have_content('Affichage de la liste des posts')
		rendered.should_not have_content('Creation d\'un nouveau post')
	end
	
	it "should display a link with 'id = post.id' to read the post" do
		@posts.each do |p|	
			rendered.should have_link("#{p.id}", :href => consult_path(p.id))
		end  	
	end

	it "should display the author of post after link post" do
		@posts.each do |p|	
			rendered.should have_content("#{p.title}")
			rendered.should =~ /[Auteur : #{Person.find_by_id(p.person_id).login}]/			
		end 
	end
	  
	it "should not have a button 'supprimer' by post because no person logged" do
	  	rendered.should_not have_button("Supprimer")         		  	  	  	
	end
	
	it "should notdisplay 'Modifie le :' and 'time_tag @post.updated_at'" do
		@posts.each do |p|	
			rendered.should have_content ("Modifie le : ")
			rendered.should =~ /#{time_tag p.updated_at}/
		end  		
	end
		
	it "should display '[Derniere modification : ' and 'sec', 'h', 'mois' and 'min' (in function of updated_at)" do
		rendered.should have_content ("[ Derniere modification : ")
		rendered.should have_content ("sec")	
		rendered.should have_content ("h")
		rendered.should have_content ("min")
		rendered.should have_content ("mois")																
	end			

	it "should not display 'an' because of updated_at much recent" do
		rendered.should_not have_content ("an")																	
	end	
	
	it "should display note of post if note != nil" do
		@posts.each do |p|	
			if p.note_post != nil
				rendered.should have_content ("Note : ")
				rendered.should =~ /#{p.note_post}/
			end
		end  
	end
			
end

#---------------------------------------------User logged-----------------------------------------------
describe "post/index.html.erb" do
	before(:each) do	
		@person = Person.create(:name => "b", :firstname => "ab", :login => "capybarab", :password => "aaAzeaz")		
		@person1 = Person.create(:name => "a", :firstname => "aa", :login => "capybara", :password => "aaAzeaz")		
		@post1 = stub_model(Post, :person_id => @person.id, :title => "sujet1", :updated_at => "2011-12-23 12:17:47")
		@post2 = stub_model(Post, :person_id => @person1.id, :title => "sujet2", :updated_at => "2010-10-21 10:24:00")
		@posts = [@post1, @post2]		
		session[:id] = @person.id
		session[:login] = @person.login				
		render
	end	
	
	it "should have a button 'supprimer' by post if user logged is a owner" do
	  	rendered.should have_button("Supprimer")  
		@posts.each do |p| 	
			if p.person_id = session[:id]
		  		rendered.should have_selector("input", :type => "submit", :href => delete_path(p.id))
		  	end
		end 		     		  	  	  	
	end		

	it "should display 'Bienvenue <%= session[:login] %>' if user logged" do
		rendered.should have_content("Bienvenue #{session[:login]}")
	end

    	it "should have a button named 'Add New Post' for create a post" do
		rendered.should have_selector("input", :type => "submit", :name => "Add New Post", :href => posts_new_path) 
		rendered.should have_button("Add New Post")
	end
	
	it "display 'Affichage des posts', display'Creation des posts' and 'Nouveau Post :'" do
		rendered.should have_content('Affichage de la liste des posts')
		rendered.should have_content('Creation d\'un nouveau post')
	end
	
	it "should not display a window to permit the authentication if already logged" do
		rendered.should_not have_content('Connexion')	
		rendered.should_not have_content('Login')
		rendered.should_not have_content('Password')
		rendered.should_not have_button("Connexion")
	end	
	
	it "should have a link 'Deconnexion'" do
		rendered.should have_link("Deconnexion")
	end	
	
	it "should have button 'Page des utilisateurs'" do
		rendered.should have_button("Page des utilisateurs")
		rendered.should have_content("Utilisateurs")
	end
	
	it "should have button 'Rechercher un message'" do
		rendered.should have_button("Search")
		rendered.should have_content("Recherche de message(s)")
	end	
		
end

	
	
	
	
	
