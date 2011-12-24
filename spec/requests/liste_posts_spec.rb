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
		@person = Person.create(:login => "froz312", :name => "aa", :firstname => "bb", :password => "2", :id => "17")	
		@post1 = Post.create(:person_id => @person.id, :title => "sujet1", :body => "Ceci est le sujet en attente de modification")
		@post2 = Post.create(:person_id => @person.id, :title => "sujet1", :body => "body2")		
		visit search_path
	end	
	
	it "Verify button 'Search' presence" do
		page.should have_button('Search')
	end
	
	it "should have content 'Mot(s) ou morceau de message :' and 'Auteur'" do
		page.should have_content('Mot(s) ou morceau de message :')
		page.should have_content('Auteur :')
	end

	it "verify ClickRetourPageAcceuilPresence" do
		page.should have_button('Page d\'accueil')	
		click_button('Page d\'accueil')
		current_path.should == posts_path		
	end		

end

#---------------------------------------------------------		
describe "PostListing" do
	before (:each) do
		@person = Person.create(:login => "froz312", :name => "aa", :firstname => "bb", :password => "2", :id => "17")	
		@post1 = Post.create(:person_id => @person.id, :title => "sujet1", :body => "Ceci est le sujet en attente de modification")
		@post2 = Post.create(:person_id => @person.id, :title => "sujet1", :body => "body2")		
		visit search_path
		click_button("Search")
	end	
	
	it "should have content 'Affichage de la liste des posts trouves'" do
		page.should have_content('Affichage de la liste des posts trouves')
	end

	it "verify ClickRetourPageAcceuilPresence" do
		page.should have_button('Page d\'accueil')	
		click_button('Page d\'accueil')
		current_path.should == posts_path		
	end	
	
	it "verify button presence 'Nouvelle recherche'" do
		page.should have_button('Nouvelle recherche')	
		click_button('Nouvelle recherche')
		current_path.should == search_path		
	end				

end





