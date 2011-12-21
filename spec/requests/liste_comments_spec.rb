require 'spec_helper'

describe "CommentCreate" do
	before (:each) do
		@person = Person.create(:login => "froz312", :name => "aa", :firstname => "bb", :password => "2", :id => "17")	
		@post1 = Post.create(:person_id => @person.id, :title => "sujet1", :body => "bla bla")
		@post2 = Post.create(:person_id => @person.id, :title => "sujet2", :body => "bla bla")
		@comment1 = Comment.create(:author => "Guillaume", :body => "RoR", :post_id => @post2.id)
		@comment2 = Comment.create(:author => "Adrien", :body => "Capybara", :post_id => @post1.id)
		@comment3 = Comment.create(:author => "Gautier", :body => "REST", :post_id => @post1.id)		
		@comments = [@comment1, @comment2, @comment3]
		visit posts_path
		visit login_path			
	end
	
	describe "GET /posts/:id" do
		it "verifyLoginPagePresence" do
			visit login_path
			current_path.should == login_path	
			page.should have_button ("Connexion")
			page.body.should include("Login :")				
			page.body.should include("Password :")			
		end	
		
		it "verifyFillingFields" do
			visit login_path		
			fill_in('login', :with => @person.login)
			fill_in('password', :with => @person.password)	
		end	
	end	
end

describe "CommentCreate" do
	before (:each) do
		@person = Person.create(:login => "froz312", :name => "aa", :firstname => "bb", :password => "2", :id => "17")	
		@post1 = Post.create(:person_id => @person.id, :title => "sujet1", :body => "bla bla")
		@post2 = Post.create(:person_id => @person.id, :title => "sujet2", :body => "bla bla")
		@comment1 = Comment.create(:author => "Guillaume", :body => "RoR", :post_id => @post2.id)
		@comment2 = Comment.create(:author => "Adrien", :body => "Capybara", :post_id => @post1.id)
		@comment3 = Comment.create(:author => "Gautier", :body => "REST", :post_id => @post1.id)		
		@comments = [@comment1, @comment2, @comment3]
		visit posts_path
		visit login_path
		fill_in('login', :with => @person.login)
		fill_in('password', :with => @person.password)
		click_button ('Connexion')		
		
	end

	describe "GET /posts/:id" do
		it "verifyClickButtonAddCommentaire" do
			visit consult_path(:id => @post2.id)
			current_path.should == consult_path(:id => @post2.id)
			page.should have_button ("Edit")	
			page.should have_button ("Add Commentaire")		
		end	
			
		it "verifyPageAfterClickAddCommentaire" do
			visit consult_path(:id => @post2.id)
			current_path.should == consult_path(:id => @post2.id)
			click_on("Add Commentaire")
			current_path.should == newComment_path(:id => @post2.id)			
			page.body.should include("Auteur")
			page.body.should include("Commentaire")		
		end	
		
		it "verifyReturnHomePageAfterClick Page d\'accueil" do
			visit consult_path(:id => @post2.id)
			current_path.should == consult_path(:id => @post2.id)
			click_on("Add Commentaire")	
			current_path.should == newComment_path(:id => @post2.id)					
			page.should have_button ("Page d'accueil")					
		end
		
		it "generates a listing of comments associated at '@post1.id' by 'post_id'" do
			visit consult_path(:id => @post1.id)		
			@comments.each do |c| 		
				if c.post_id == @post1.id				
					page.body.should include(c.author)
					page.body.should include(c.body)					
				end			
			end
			page.body.should_not include(@comment1.author)
			page.body.should_not include(@comment1.body)					
		end		
		
		it "verify ReturnButton 'Precedent'" do
			visit consult_path(:id => @post2.id)
			current_path.should == consult_path(:id => @post2.id)
			click_on("Add Commentaire")	
			current_path.should == newComment_path(:id => @post2.id)			
			page.should have_button ("Precedent")	
			click_on("Precedent")
			current_path.should == consult_path(:id => @post2.id)									
		end			
	end	
end
#-----------------------------------------------------------------------------------------------------------------------
describe "CommentDelete" do
	before (:each) do
		@person = Person.create(:login => "froz312", :name => "aa", :firstname => "bb", :password => "2", :id => "17")	
		@post1 = Post.create(:person_id => @person.id, :title => "sujet1", :body => "corps du sujet 1", :id => "1")
		@post2 = Post.create(:person_id => @person.id, :title => "sujet2", :body => "corps du sujet 2", :id => "2")		
		@comment1 = Comment.create(:author => "Guillaume", :body => "Ruby", :post_id => @post1.id)		
		@comment2 = Comment.create(:author => "Adrien", :body => "Capybara", :post_id => @post1.id)
		@comment3 = Comment.create(:author => "Gautier", :body => "REST", :post_id => @post1.id)
		@comment4 = Comment.create(:author => "Alex", :body => "Rspec", :post_id => @post2.id)		
		@comments = [@comment1, @comment2, @comment3,@comment4]							
		visit posts_path
		visit login_path
		fill_in('login', :with => @person.login)
		fill_in('password', :with => @person.password)
		click_button ('Connexion')
		visit consult_path(:id => @post1.id)		
	end

	describe "DELETE /posts/:id" do
		it "verifyCurrentPath" do
			current_path.should == consult_path(:id => @post1.id)
		end	

		it "generates a listing of comments associated at '@post1.id' by 'post_id'" do
			@comments.each do |c| 		
				if c.post_id == @post1.id				
					page.body.should include(c.author)
					page.body.should include(c.body)					
				end			
			end
			page.body.should_not include(@comment4.author)
			page.body.should_not include(@comment4.body)					
		end	
		
		it "verifyClickButtonDeletePresence" do
			@comments.each do |c| 
				if c.post_id == @post1.id				
					page.should have_button("Delete#{c.id}")
					page.should have_button("Supprimer")				
				end
				page.should_not have_button("Delete#{@comment4.id}")							
			end
		end

		it "verifyAfterClickButtonDelete" do
			click_button("Delete#{@comment2.id}")
			current_path.should == consult_path(:id => @post1.id)				
			page.should have_button("Delete#{@comment1.id}")
			page.body.should include(@comment1.author)
			page.body.should include(@comment1.body)			
			page.should have_button("Delete#{@comment3.id}")
			page.body.should include(@comment3.author)
			page.body.should include(@comment3.body)						
			page.should_not have_button("Delete#{@comment2.id}")
			#La page doit inclure le titre 2 car flash[:notice] retourne l'auteur. Cf test suivant.
			page.body.should include(@comment2.author)
			page.body.should_not include(@comment2.body)										
			page.should_not have_button("Delete#{@comment4.id}")
			page.body.should_not include(@comment4.author)
			page.body.should_not include(@comment4.body)								
		end	
		
		it "display '200 : Le commentaire de @comment.author} a ete supprime avec succes' if response is success." do
			click_button("Delete#{@comment2.id}")					
			current_path.should == consult_path(:id => @post1.id)	
			page.should have_content("200 : Le commentaire de #{@comment2.author} a ete supprime avec succes")
		end
	end
end	
#------------------------------------------------------------------------------------------------------------------------		
describe "CommentEdit" do
	before (:each) do
		@person = Person.create(:login => "froz312", :name => "aa", :firstname => "bb", :password => "2", :id => "17")	
		@post1 = Post.create(:person_id => @person.id, :title => "sujet1", :body => "corps du sujet 1", :id => "1")
		@post2 = Post.create(:person_id => @person.id, :title => "sujet2", :body => "corps du sujet 2", :id => "2")		
		@comment1 = Comment.create(:author => "Guillaume", :body => "Ruby ou Ruby on Rails????????", :post_id => @post1.id)		
		@comment2 = Comment.create(:author => "Adrien", :body => "Capybara", :post_id => @post1.id)		
		@comments = [@comment1, @comment2]							
		visit posts_path
		visit login_path
		fill_in('login', :with => @person.login)
		fill_in('password', :with => @person.password)
		click_button ('Connexion')
		visit consult_path(:id => @post1.id)
		visit editCom_path(:id => @post1.id, :comment_id => @comment1.id)		
	end
	
		describe "GET /posts/:id/comments/:comment_id" do
			it "verifyCurrentPath" do
				current_path.should == editCom_path(:id => @post1.id, :comment_id => @comment1.id)	
			end	
			
			it "verify ReturnButton 'Precedent'" do			
				page.should have_button ("Precedent")	
				click_on("Precedent")
				current_path.should == consult_path(:id => @post1.id)											
			end			

		end

end	












