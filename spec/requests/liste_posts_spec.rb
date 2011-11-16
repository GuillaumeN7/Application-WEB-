require 'spec_helper'

describe "PostListings" do
	before (:each) do
		@post1 = Post.create(:title => "sujet1", :body => "bla bla")
		@post2 = Post.create(:title => "sujet2", :body => "bla bla")
		visit posts_path
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
			current_path.should == "/posts/new"
		end
	end
end
#-------------------------------------------------------------
describe "PostCreation" do
	before (:each) do
		visit posts_new_path
	end	

	describe "GET /posts/new" do
		it "verifyCurrentPath" do
			current_path.should == "/posts/new"
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
			current_path.should == "/posts"
			page.should have_content('TOP 14 Orange')
		end
		it "verify ClickRetourPageAcceuilPresence" do
			page.should have_button('Page d\'accueil')	
			click_button('Page d\'accueil')
			current_path.should == "/posts"			
		end		
	end


	describe "POST /posts" do
		it "After Click go on posts/new" do
			fill_in('title', :with => 'D1 et D2')
			fill_in('body', :with => 'TFC')
			click_button('Valider')
			current_path.should == "/posts"
		end
	end
end	
#---------------------------------------------------------------------------------
describe "PostDelete" do
	before (:each) do
		@post1 = Post.create(:title => "sujet1garde", :body => "stay")
		@post2 = Post.create(:title => "sujet2delete", :body => "deleted")
		visit posts_path
	end
	describe "DELETE /posts" do
		it "verifyCurrentPath" do
			current_path.should == "/posts"
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
			current_path.should == "/posts"
			page.body.should include(@post1.title)
			page.body.should_not include(@post2.title)
		end		
	end
end	
#---------------------------------------------------------		
describe "PostConsult" do
	before (:each) do
		@post1 = Post.create(:title => "sujet1", :body => "Ceci est le sujet 1")
		@post2 = Post.create(:title => "sujet2Consulte", :body => "Ceci est le sujet consulte")
		visit posts_path
	end	
	describe "GET /posts/:id" do
		it "verifyCurrentPath" do
			current_path.should == "/posts"
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
	end
end
#---------------------------------------------------------		
describe "PostEdit" do
	before (:each) do
		@post1 = Post.create(:title => "sujet1", :body => "Ceci est le sujet en attente de modification")
		visit posts_path
	end	
		describe "PUT /posts/:id" do
			it "verifyCurrentPath" do
				current_path.should == "/posts"
			end	
			it "verifyClickButtonModifyPresence" do
				page.should have_button("#{@post1.id}")
			end	
			it "verifyAfterClick" do
				click_link("#{@post1.id}")
				current_path.should == "/posts/#{@post1.id}"
				page.body.should include(@post1.title)
				page.body.should include(@post1.body)						
			end	
			it "verifyClickButtonModifyPresence" do
				page.should have_button("#{@post1.id}")
			end	
			it "ModifOperation" do
				click_link("#{@post1.id}")
				current_path.should == "/posts/#{@post1.id}"
				page.body.should include(@post1.title)
				page.body.should include(@post1.body)
				click_button("#{@post1.id}")
				current_path.should == "/posts/#{@post1.id}"
				page.body.should include(@post1.title)
				page.body.should include(@post1.body)
				fill_in('body', :with => 'Body modifie OK')
				click_button("Valider")	
				current_path.should == "/posts/#{@post1.id}"		
				page.should have_content('Body modifie OK')							
			
				
			end	
	
	end
end










