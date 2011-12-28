require 'spec_helper'

#not logged
describe "post/read.html.erb" do
	before(:each) do
		@person = Person.create(:id => "1", :name => "gui", :firstname => "gui", :login => "lala", :password => "2")
		@post1 = stub_model(Post, :person_id => @person.id, :title => "titre du post", :body => "corps du post", :id => "24")
		@comment1 = stub_model(Comment, :author => "Guillaume", :body => "com pour le test de la vue", :post_id =>@post1.id)
		@comment2 = stub_model(Comment, :author => "Pauline", :body => "2eme com pour le test", :post_id =>@post1.id)
		@comment3 = stub_model(Comment, :author => "lala", :body => "3eme com pour le test", :post_id =>@post1.id)			
		@comments = [@comment1, @comment2, @comment3]			
		assign(:post, @post1)
		assign(:comments, [@comment1, @comment2, @comment3])
		controller.request.path_parameters[:id] = @post1.id
		render
	end

	it "should not have a button named 'Modifier' for modify the post" do
		rendered.should_not have_button("Modifier")
	end

	it "should have a button to go at home page displaying 'Page d'accueil'" do
		rendered.should have_selector("input", :type => "submit", :name => "Page d'accueil", :href => posts_path) 
		rendered.should have_button("Page d'accueil")
	end 
    
    	it "should have a button named 'Add Commentaire' for add a commentaire at post" do
		rendered.should have_selector("input", :type => "submit", :name => "Add Commentaire", :href => newComment_path) 
		rendered.should have_button("Add Commentaire")
	end
	
	it "should not have a button Edit for all comments posted because no user logged" do
		@comments.each do |c| 			
			rendered.should have_selector("input", :type => "submit", :href => editCom_path(c.post_id, c.id))	
			rendered.should_not have_button("Edit")						
		end 
	end

	it "should not have a button Supprimer for all comments posted" do
		@comments.each do |c| 			
			rendered.should have_selector("input", :type => "submit", :href => deleteCom_path(c.post_id, c.id))
			rendered.should_not have_button("Supprimer")			
		end 
	end	
	
	it "should have content displaying vote information" do
		rendered.should have_content("Note moyenne des utilisateurs : ")
		rendered.should have_content("/5")	
		rendered.should have_content("votant")		
	end
	

    it "displays a textfield 'Consultation du post :' with value = 'post.title' and a textareafield 'Message :' with value = 'post.body' " do
   		rendered.should have_selector("input", :type => "text") 
    		rendered.should have_content('Consultation du post')
    		rendered.should have_content('et de ses commentaires')	    		
   		rendered.should have_selector('input', :content => @post1.title)
		rendered.should have_content('Message : ')
   		rendered.should have_selector("textarea", :content => @post1.body) 
	end	
end

#logged + tag non existant
describe "post/read.html.erb" do
	before(:each) do
		@person = Person.create(:id => "1", :name => "caen", :firstname => "gui", :login => "capybara", :password => "2")
		@post1 = stub_model(Post, :person_id => @person.id, :title => "titre du post", :body => "corps du post", :id => "24")
		@comment1 = stub_model(Comment, :author => "Guillaume", :body => "com pour le test de la vue", :post_id =>@post1.id)
		@comment2 = stub_model(Comment, :author => "Pauline", :body => "2eme com pour le test", :post_id =>@post1.id)	
		@comments = [@comment1, @comment2]				
		session[:id] = @person.id	
		session[:login] = @person.login						
		assign(:post, @post1)
		assign(:comments, [@comment1, @comment2])
		controller.request.path_parameters[:id] = @post1.id
		render
	end
	
	it "should have a button named 'Modifier' for modify the post" do
		rendered.should have_selector("input", :type => "submit", :name => "Modifier", :href => accessModify_path(@post1.id)) 
		rendered.should have_button("Modifier")
	end

	it "should have a button Supprimer for comments posted if post's owner or comment's owner logged" do
		@comments.each do |c|	
			rendered.should have_selector("input", :type => "submit", :href => deleteCom_path(c.post_id, c.id))
		end 
	end
	
	it "should have a link 'Deconnexion'" do
		rendered.should have_link("Deconnexion")
	end	
	
	it "should have a click button 'Valider'" do
		rendered.should have_button("Valider")
	end	
	
	it "should display '<%= session[:login] %> logged' if user logged" do
		rendered.should have_content("#{session[:login]} logged")
	end	
	
	it "should display 'Tagger le post :' if no tag found and have a button valider" do
		rendered.should have_content("Tagger le post :")	
		rendered.should have_button('Tagger')	
	end
end

#logged + tag existant
describe "post/read.html.erb" do
	before(:each) do
		@person = Person.create(:id => "1", :name => "caen", :firstname => "gui", :login => "capybara", :password => "2")
		@post1 = stub_model(Post, :person_id => @person.id, :title => "titre du post", :body => "corps du post", :id => "24")
		@comment1 = stub_model(Comment, :author => "Guillaume", :body => "com pour le test de la vue", :post_id =>@post1.id)
		@comment2 = stub_model(Comment, :author => "Pauline", :body => "2eme com pour le test", :post_id =>@post1.id)	
		@tag = Tag.create(:person_id => @person.id, :post_id => @post1.id)
		@comments = [@comment1, @comment2]				
		session[:id] = @person.id	
		session[:login] = @person.login						
		assign(:post, @post1)
		assign(:comments, [@comment1, @comment2])
		controller.request.path_parameters[:id] = @post1.id
		render
	end	
	
	it "should display 'deTagger le post :' if a tag found and have a button valider" do
		rendered.should have_content("Detagger le post :")	
		rendered.should have_button('Detagger')		
	end
end






