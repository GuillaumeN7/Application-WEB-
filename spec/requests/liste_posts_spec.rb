require 'spec_helper'

describe "PostListings" do
	before (:each) do
		@person = Person.create(:login => "froz312", :name => "aa", :firstname => "bb", :password => "2", :id => "17")	
		@post1 = Post.create(:person_id => @person.id, :title => "sujet1", :body => "bla bla")
		@post2 = Post.create(:person_id => @person.id, :title => "sujet2", :body => "bla bla")
		visit posts_path
		visit login_path
		fill_in('login', :with => @person.login)
		fill_in('password', :with => @person.password)
		click_button ('Connexion')
	end

	describe "GET /posts" do
		it "generates a listing of posts" do
			page.body.should include(@post1.title)
			page.body.should include(@post2.title)
		end
		
		it "verify ClickButtonPresence" do
			page.has_xpath?('//input[@id="Add New Post"]')
			click_button('Add New Post')
		end
		
		it "After Click go on posts/new" do
			click_button('Add New Post')
			current_path.should == posts_new_path
		end
		
		it "Verify clickButton SearchPresence" do
			page.should have_content("Recherche de message(s)")
			page.should have_button("Search")
			click_button("Search")
			current_path.should == search_path
		end				
	end
end
#-------------------------------------------------------------
describe "PostCreation" do
	before (:each) do
		@person = Person.create(:login => "froz312", :name => "aa", :firstname => "bb", :password => "2", :id => "17")
		visit posts_path
		visit login_path
		fill_in('login', :with => @person.login)
		fill_in('password', :with => @person.password)
		click_button ('Connexion')	
		visit posts_new_path
	end	

	describe "GET /posts/new" do
		it "verifyCurrentPath" do
			current_path.should == posts_new_path
		end	
		
		it "verifyClickButtonValiderPresence" do
			click_on('Valider')
		end
		
		it "verifyPresenceFormulaireAvecTitleEtBody" do
			page.should have_selector('form')
			page.should have_field('title')
			page.should have_field('body')
			page.should have_button('Valider')
		end
		
		it "fillingFieldsAndCreate" do
			fill_in('title', :with => 'TOP 14 Orange')
			fill_in('body', :with => 'Le leader actuel du top 14 est le Stade Toulousain!!!!!')
			click_button ('Valider')
			current_path.should == posts_path
			page.should have_content('TOP 14 Orange')
		end
		
		it "verify ClickRetourPageAcceuilPresence" do
			page.should have_button('Page d\'accueil')	
			click_button('Page d\'accueil')
			current_path.should == posts_path		
		end		
	end


	describe "POST /posts" do
		it "After Click go on posts_path" do
			fill_in('title', :with => 'D1 et D2')
			fill_in('body', :with => 'TFC')
			click_button('Valider')
			current_path.should == posts_path
		end
	end
end	
#---------------------------------------------------------------------------------
describe "PostDelete" do
	before (:each) do
		@person = Person.create(:login => "froz312", :name => "aa", :firstname => "bb", :password => "2", :id => "17")	
		@post1 = Post.create(:person_id => @person.id, :title => "sujet1garde", :body => "stay")
		@post2 = Post.create(:person_id => @person.id, :title => "sujet2delete", :body => "deleted")
		visit posts_path
		visit login_path
		fill_in('login', :with => @person.login)
		fill_in('password', :with => @person.password)
		click_button ('Connexion')
	end
	describe "DELETE /posts" do
		it "verifyCurrentPath" do
			current_path.should == posts_path
		end	
		it "generates a listing of posts" do
			page.body.should include(@post1.title)
			page.body.should include(@post2.title)
		end
		it "verifyClickButtonDeletePresence" do
			page.should have_button("#{@post2.id}")
		end
		it "verifyAfterClick" do
			click_button("#{@post2.id}")
			current_path.should == posts_path
			page.body.should include(@post1.title)
			page.body.should_not include(@post2.title)
		end		
	end
end	
#---------------------------------------------------------		
describe "PostConsult" do
	before (:each) do
		@person = Person.create(:login => "froz312", :name => "aa", :firstname => "bb", :password => "2", :id => "17")
		@votant2 = Person.create(:login => "gamba", :name => "aa", :firstname => "bb", :password => "4", :id => "12")		
		@post1 = Post.create(:person_id => @person.id, :title => "sujet1", :body => "Ceci est le sujet 1")
		@post2 = Post.create(:person_id => @person.id, :title => "sujet2Consulte", :body => "Ceci est le sujet consulte")
		visit posts_path
		visit login_path
		fill_in('login', :with => @person.login)
		fill_in('password', :with => @person.password)
		click_button ('Connexion')
	end	
	
	describe "GET /posts/:id" do	
		it "verifyCurrentPath" do
			current_path.should == posts_path
		end	
		
		it "generates a listing of posts" do
			page.body.should include(@post1.title)
			page.body.should include(@post2.title)
		end
		
		it "verifyLinkPostPresence" do
			page.should have_link("#{@post2.id}")
		end
		
		it "verifyAfterClick" do
			click_link("#{@post2.id}")
			current_path.should == "/posts/#{@post2.id}"
			page.body.should include(@post2.title)
			page.body.should include(@post2.body)
			page.body.should_not include(@post1.title)
			page.body.should_not include(@post1.title)						
		end	
		
		it "verify ClickRetourPageAcceuilPresence" do
			click_link("#{@post2.id}")
			page.should have_button('Page d\'accueil')	
			click_button('Page d\'accueil')
			current_path.should == posts_path		
		end	
		
		it "should display @post.note_post after choose radio_button" do
			click_link("#{@post2.id}")
			page.choose('note_1')
			click_button('Valider')
			page.should have_content('Note moyenne des utilisateurs : ')
			page.should have_content('1/5')
			page.should have_content('1 seul votant')
		end		
		
		it "should display @post.note_post after 2 votes" do
			click_link("#{@post2.id}")
			page.choose('note_1')
			click_button('Valider')
			page.should have_content('Note moyenne des utilisateurs : ')
			page.should have_content('1/5')
			page.should have_content('1 seul votant')
			
			#deconnexion du premier votant
			click_link('Deconnexion')
			
			#connexion du deuxieme votant
			visit login_path
			fill_in('login', :with => @votant2.login)
			fill_in('password', :with => @votant2.password)
			click_button ('Connexion')
						
			#deuxieme vote
			click_link("#{@post2.id}")
			page.choose('note_3')
			click_button('Valider')
			page.should have_content('Note moyenne des utilisateurs : ')
			page.should have_content('2/5')
			page.should have_content('2 votants')			
		end		
	end
end
#---------------------------------------------------------		
describe "PostEdit" do
	before (:each) do
		@person = Person.create(:login => "froz312", :name => "aa", :firstname => "bb", :password => "2", :id => "17")	
		@post1 = Post.create(:person_id => @person.id, :title => "sujet1", :body => "Ceci est le sujet en attente de modification")
		visit posts_path
		visit login_path
		fill_in('login', :with => @person.login)
		fill_in('password', :with => @person.password)
		click_button ('Connexion')
	end	
		describe "PUT /posts/:id" do
			it "verifyCurrentPath" do
				current_path.should == posts_path
			end	
			it "verifyClickButtonModifyPresence" do
				page.should have_button("#{@post1.id}")				
			end	
			it "verifyAfterClick" do
				click_link("#{@post1.id}")		
				current_path.should == consult_path(@post1.id)			
				current_path.should == accessModify_path(@post1.id)				
				page.body.should include(@post1.title)
				page.body.should include(@post1.body)						
			end	

			it "ModifOperation" do
				click_link("#{@post1.id}")
				current_path.should == consult_path(@post1.id)
				page.body.should include(@post1.title)
				page.body.should include(@post1.body)
				click_button("Modifier")
				current_path.should == accessModify_path(@post1.id)
				page.body.should include(@post1.title)
				page.body.should include(@post1.body)
				fill_in('body', :with => 'Body modifie OK')
				click_button("Valider")	
				current_path.should == consult_path(@post1.id)		
				page.should have_content('Body modifie OK')											
			end
			
			it "verify ClickRetourPageAcceuilPresence" do
				click_link("#{@post1.id}")
				click_button("Modifier")
				page.should have_button('Page d\'accueil')	
				click_button('Page d\'accueil')
				current_path.should == posts_path		
			end					
	
	end
end

#---------------------------------------------------------		
describe "PostSearch" do
	before (:each) do
		@person = Person.create(:login => "Guil", :name => "CA", :firstname => "lala", :password => "2", :id => "17")	
		@person2 = Person.create(:login => "Laume", :name => "EN", :firstname => "lili", :password => "2", :id => "18")			
		@post1 = stub_model(Post, :person_id => @person.id, :title => "sujet1", :body => "body1")
		@post2 = stub_model(Post, :person_id => @person.id, :title => "sujet2", :body => "body2")		
		@post3 = stub_model(Post, :person_id => @person2.id, :title => "sujet3", :body => "body3")	
		@post4 = stub_model(Post, :person_id => @person2.id, :title => "sujet4", :body => "body4")					
		visit search_path
	end	
	
	it "Verify button 'Search' presence" do
		page.should have_button('Search')
		click_button ('Search')
		#no parameters so : redirected_to search_path
		current_path.should == search_path						
	end
	
	it "should have content 'Mot(s) ou morceau de message :' and 'Auteur' and 'Titre :'" do
		page.should have_content('Mot(s) ou morceau de message :')
		page.should have_content('Auteur :')
		page.should have_content('Titre :')
	end

	it "verify ClickRetourPageAcceuilPresence" do
		page.should have_button('Page d\'accueil')	
		click_button('Page d\'accueil')
		current_path.should == posts_path		
	end	
	
	# Research OK	
	it "make research by author" do
		fill_in('auteurSrch', :with => @person.login)		
		click_button("Search")
		current_path.should == listing_research_path	
	end
	
	it "make research by author and title" do
		fill_in('auteurSrch', :with => @person.login)
		fill_in('titreSrch', :with => @post1.title)					
		click_button("Search")
		current_path.should == listing_research_path	
	end	

	it "make research by author, title and body" do
		fill_in('auteurSrch', :with => @person.login)	
		fill_in('titreSrch', :with => @post1.title)		
		fill_in('messSrch', :with => @post1.body)			
		click_button("Search")
		current_path.should == listing_research_path	
	end		

	it "make research by title" do
		fill_in('titreSrch', :with => @post1.title)		
		click_button("Search")
		current_path.should == listing_research_path	
	end
	
	it "make research by title and body" do
		fill_in('titreSrch', :with => @post1.title)	
		fill_in('messSrch', :with => @post1.body)				
		click_button("Search")
		current_path.should == listing_research_path	
	end		
	
	it "make research by body" do
		fill_in('messSrch', :with => @post1.body)		
		click_button("Search")
		current_path.should == listing_research_path	
	end		
	
	# Research FAILED because bad author
	it "make research with a bad author" do
		fill_in('auteurSrch', :with => "jexistepas")		
		click_button("Search")
		current_path.should == search_path	
	end

	it "make research with a bad author and good title" do
		fill_in('auteurSrch', :with => "jexistepas")
		fill_in('titreSrch', :with => @post1.title)				
		click_button("Search")
		current_path.should == search_path	
	end
	
	it "make research with a bad author and good body" do
		fill_in('auteurSrch', :with => "jexistepas")	
		fill_in('messSrch', :with => @post1.body)			
		click_button("Search")
		current_path.should == search_path	
	end	
	
	it "make research with a bad author, good title and body" do
		fill_in('auteurSrch', :with => "jexistepas")
		fill_in('titreSrch', :with => @post1.title)			
		fill_in('messSrch', :with => @post1.body)			
		click_button("Search")
		current_path.should == search_path	
	end		
	
end

#---------------------------------------------------------		
describe "PostListing" do
	before (:each) do
		@person = Person.create(:login => "Guil", :name => "CA", :firstname => "lala", :password => "2", :id => "17")	
		@person2 = Person.create(:login => "Laume", :name => "EN", :firstname => "lili", :password => "2", :id => "24")			
		@post1 = Post.create(:person_id => @person.id, :title => "sujet1", :body => "body1")
		@post2 = Post.create(:person_id => @person.id, :title => "sujet2", :body => "body2")		
		@post3 = Post.create(:person_id => @person2.id, :title => "sujet3", :body => "body3")	
		@post4 = Post.create(:person_id => @person2.id, :title => "sujet4", :body => "body4")
		@posts = [@post1, @post2, @post3, @post4]		
		visit search_path
	end	
	
	it "should be in listing_research_path" do
		fill_in('auteurSrch', :with => @person.login)		
		click_button("Search")	
		current_path.should == listing_research_path
	end
	
	it "should have content 'Affichage de la liste des posts trouves'" do
		fill_in('auteurSrch', :with => @person.login)		
		click_button("Search")	
		page.should have_content('Affichage de la liste des posts trouves')
	end

	it "verify ClickRetourPageAcceuilPresence" do
		fill_in('auteurSrch', :with => @person.login)		
		click_button("Search")	
		page.should have_button('Page d\'accueil')	
		click_button('Page d\'accueil')
		current_path.should == posts_path		
	end	
	
	it "verify button presence 'Nouvelle recherche'" do
		fill_in('auteurSrch', :with => @person.login)		
		click_button("Search")	
		page.should have_button('Nouvelle recherche')	
		page.should have_content("Nouvelle recherche")
		click_button('Nouvelle recherche')
		current_path.should == search_path		
	end	

# LISTING TESTS	
	# Research OK	
	it "make research by author : it should generate listing with posts of @person" do
		fill_in('auteurSrch', :with => @person.login)		
		click_button("Search")
		current_path.should == listing_research_path	
		@posts.each do |p| 	
			if p.person_id == @person.id
		  		page.body.should include(@person.login)
		  		page.should have_link(p.title)
		  	else	  	
		  		page.should_not have_link(p.title)
		 	end
		end 	
	end
	
	it "make research by author and title : it should generate listing with posts of 'titreSrch' whom 'titreSrch' = @post1.title" do
		fill_in('auteurSrch', :with => @person.login)
		fill_in('titreSrch', :with => @post1.title)					
		click_button("Search")
		current_path.should == listing_research_path	
		@posts.each do |p| 	
			if p.person_id == @person.id and p.title == @post1.title
		  		page.body.should include(@person.login)
		  		page.should have_link(p.title)
		  	else	  	
		  		page.should_not have_link(p.title)
		 	end
		end 			
	end	
	
	it "make research by author and body : it should generate listing with posts of @person whom 'body' = @post1.body" do
		fill_in('auteurSrch', :with => @person.login)
		fill_in('messSrch', :with => @post1.body)					
		click_button("Search")
		current_path.should == listing_research_path	
		@posts.each do |p| 	
			if p.person_id == @person.id and p.body == @post1.body
		  		page.body.should include(@person.login)
		  		page.should have_link(p.title)
		  	else	  	
		  		page.should_not have_link(p.title)
		 	end
		end 			
	end	
	
	it "make research by author and extract(body) : it should generate listing with posts of 'titreSrch' whom 'titreSrch' = @post1.title" do
		fill_in('auteurSrch', :with => @person.login)
		fill_in('messSrch', :with => 'body')					
		click_button("Search")
		current_path.should == listing_research_path	
		@posts.each do |p| 	
			if p.person_id == @person.id and p.body =~ /body/
		  		page.body.should include(@person.login)
		  		page.should have_link(p.title)
		  	else	  	
		  		page.should_not have_link(p.title)
		 	end
		end 			
	end			

	it "make research by author, title and body :  it should generate listing with posts of 'titreSrch' whom 'titreSrch' = @post1.title
	and whom body = @post1.body" do
		fill_in('auteurSrch', :with => @person.login)	
		fill_in('titreSrch', :with => @post1.title)		
		fill_in('messSrch', :with => @post1.body)			
		click_button("Search")
		current_path.should == listing_research_path	
		@posts.each do |p| 	
			if p.person_id == @person.id and p.title == @post1.title and p.body == @post1.body
		  		page.body.should include(@person.login)
		  		page.should have_link(p.title)
		  	else	  	
		  		page.should_not have_link(p.title)
		 	end
		end 			
	end		
	
	it "make research by author, title and extract(body) :  it should generate listing with posts of 'titreSrch' whom 'titreSrch' = @post1.title
	and whom body = extract(@post1.body)" do
		fill_in('auteurSrch', :with => @person.login)	
		fill_in('titreSrch', :with => @post1.title)		
		fill_in('messSrch', :with => 'body')			
		click_button("Search")
		current_path.should == listing_research_path	
		page.body.should include(@person.login)		
		@posts.each do |p| 	
			if p.person_id == @person.id and p.title == @post1.title and p.body =~ /body/
		  		page.should have_link(p.title)
		  	else	  	
		  		page.should_not have_link(p.title)
		 	end
		end 			
	end			

	it "make research by title : it should generate listing with posts whom 'titreSrch' = @post1.title" do
		fill_in('titreSrch', :with => @post1.title)		
		click_button("Search")
		current_path.should == listing_research_path	
		@posts.each do |p| 	
			if p.title == @post1.title
		  		page.body.should include(@person.login)
		  		page.should have_link(p.title)
		  	else	  	
		  		page.should_not have_link(p.title)
		 	end
		end 		
	end
	
	it "make research by title and body : it should generate listing with posts whom 'titreSrch' = @post1.title
	and 'messSrch' = @post1.body" do
		fill_in('titreSrch', :with => @post1.title)	
		fill_in('messSrch', :with => @post1.body)				
		click_button("Search")
		current_path.should == listing_research_path	
		@posts.each do |p| 	
			if p.title == @post1.title and p.body == @post1.body
		  		page.body.should include(@person.login)
		  		page.should have_link(p.title)
		  	else	  	
		  		page.should_not have_link(p.title)
		 	end
		end 		
	end	
	
	it "make research by title and extract(body) : it should generate listing with posts whom 'titreSrch' = @post1.title
	and 'messSrch' = extract(@post1.body)" do
		fill_in('titreSrch', :with => @post1.title)	
		fill_in('messSrch', :with => "body")				
		click_button("Search")
		current_path.should == listing_research_path	
		page.body.should include(@person.login)		
		@posts.each do |p| 	
			if p.title == @post1.title and p.body =~ /body/
		  		page.should have_link(p.title)
		  	else	  	
		  		page.should_not have_link(p.title)
		 	end
		end 		
	end			
	
	it "make research by body : it should generate listing with posts whom 'messSrch' = @post1.body" do
		fill_in('messSrch', :with => @post1.body)		
		click_button("Search")
		current_path.should == listing_research_path	
		@posts.each do |p| 	
			if p.body == @post1.body
		  		page.body.should include(@person.login)
		  		page.should have_link(p.title)
		  	else	  	
		  		page.should_not have_link(p.title)
		 	end
		end 		
	end	
	
	it "make research by extract(body) : it should generate listing with posts whom 'messSrch' = extract(@post1.body)" do
		fill_in('messSrch', :with => "body")		
		click_button("Search")
		current_path.should == listing_research_path	
		# all posts contain 'body' so we have to list all post
  		page.body.should include(@person.login)
  		page.body.should include(@person2.login)
		@posts.each do |p| 	
	  		page.should have_link(p.title)
		end 		
	end		

end





