require 'spec_helper'

describe "post/read.html.erb" do
	before(:each) do
		@post1 = stub_model(Post, :title => "titre du post", :body => "corps du post", :id => "24")
		@comment1 = stub_model(Comment, :author => "Guillaume", :body => "com pour le test de la vue", :post_id =>@post1.id)
		@comment2 = stub_model(Comment, :author => "Pauline", :body => "2eme com pour le test", :post_id =>@post1.id)	
		@comments = [@comment1, @comment2]			
		assign(:post, @post1)
		assign(:comments, [@comment1, @comment2])
		controller.request.path_parameters[:id] = @post1.id
		render
	end

	it "should have a button named 'Modifier' for modify the post" do
		rendered.should have_selector("input", :type => "submit", :name => "Modifier", :href => accessModify_path(@post1.id)) 
		rendered.should have_button("Modifier")
	end

	it "should have a button to go at home page displaying 'Page d'accueil'" do
		rendered.should have_selector("input", :type => "submit", :name => "Page d'accueil", :href => posts_path) 
		rendered.should have_button("Page d'accueil")
    end 
    
    	it "should have a button named 'Add Commentaire' for add a commentaire at post" do
		rendered.should have_selector("input", :type => "submit", :name => "Add Commentaire", :href => newComment_path) 
		rendered.should have_button("Add Commentaire")
	end
	
	it "should have a button Read for all comments posted" do
		@comments.each do |c| 
# 	      	rendered.should have_button("Read#{c.id}")			
			rendered.should have_selector("input", :type => "submit", :href => consultCom_path(c.post_id, c.id))
		end 
	end
	
    it "displays a textfield 'Consultation du post :' with value = 'post.title' and a textareafield 'Message :' with value = 'post.body' " do
   		rendered.should have_selector("input", :type => "text") 
    		rendered.should have_content('Consultation du post : ')
   		rendered.should have_selector('input', :content => @post1.title)
		rendered.should have_content('Message : ')
   		rendered.should have_selector("textarea", :content => @post1.body) 
	end	
	
	


end




