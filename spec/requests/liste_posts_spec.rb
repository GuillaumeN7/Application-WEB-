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
			click_on('Add New Post')
		end
		it "After Click go on posts/new" do
			click_button('Add New Post')
			current_path.should == "/posts/new"
		end
	end
end

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
			page.should have_content('title')
			page.should have_content('body')
		end
	end
end

#		it "display new post" do
#			page.body.should include(@post3.title)
#		end






#	describe "POST /posts/new do"
#		it "After Click go on posts/new" do
#			click_button('Valider')
#			current_path.should == "/posts"
#		end
#	end
		
			
	


