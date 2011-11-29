require 'spec_helper'

describe "CommentConsult" do
	before (:each) do
		@post1 = Post.create(:title => "sujet1", :body => "bla bla")
		@post2 = Post.create(:title => "sujet2", :body => "bla bla")
		@comment = Comment.create(:author => "guillaume", :body => "test dintegration", :post_id => @post2.id)
		visit posts_path
	end

	describe "GET /posts/:id" do
		it "verifyClickButtonAddCommentaire" do
			visit consult_path(:id => @post2.id)
			current_path.should == "/posts/#{@post2.id}"
			page.should have_button ("Read")	
			page.should have_button ("Add Commentaire")		
		end	
			
		it "verifyPageAfterClickAddCommentaire" do
			visit consult_path(:id => @post2.id)
			current_path.should == "/posts/#{@post2.id}"
			click_on("Add Commentaire")
			current_path.should == "/posts/#{@post2.id}/comments/new"
			page.body.should include("Auteur")
			page.body.should include("Commentaire")		
		end	
		
		it "verifyReturnHomePageAfterClick Page d\'accueil" do
			visit consult_path(:id => @post2.id)
			current_path.should == "/posts/#{@post2.id}"
			page.should have_button ("Page d'accueil")					
		end
	end
end
#---------------------------------------------------------

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










