require 'spec_helper'

describe "comment/new.html.erb" do
	before(:each) do
		@post1 = stub_model(Post, :title => "titre du post", :body => "corps du post", :id => "24")
		assign(:post, @post1)
		render
	end

	it "display 'Auteur' and 'Commentaire'" do 
    		rendered.should have_content('Auteur')
     	rendered.should have_content('Commentaire') 
    end   

    it "displays a textfield 'author' and a textareafield 'body' " do
   		rendered.should have_selector("input", :type => "text")    
   		rendered.should have_selector("textarea") 
	end
   
    it "displays a form to create a new comment with a method post" do
       	rendered.should have_selector("form",:method => "POST")
       	rendered.should have_selector("input", :type => "submit", :name => "Valider", :href => showComment_path(@post1.id))   	
    end
    
    it "should have a button to go at home page" do
       	rendered.should have_selector("form",:method => "get")    
       	rendered.should have_selector("input", :type => "submit", :name => "Page d'accueil", :href => posts_path) 
      	rendered.should have_button("Page d'accueil")
    end   

    	it "should have a button named 'Precedent' for come back a the @post1 page" do
		rendered.should have_selector("input", :type => "submit", :name => "Precedent", :href => consult_path(@post1.id)) 
		rendered.should have_button("Precedent")
	end	
	    
end


describe "comment/new.html.erb" do
	before(:each) do	
		@post1 = stub_model(Post, :title => "titre du post", :body => "corps du post", :id => "24")
		assign(:post, @post1)
		@person = stub_model(Person, :login => "capybara")			
		session[:id] = @person.id
		session[:login] = @person.login				
		render
	end	
	it "should have a link 'Deconnexion'" do
		rendered.should have_link("Deconnexion")
	end	
	
	it "should display '<%= session[:login] %> logged' if user logged" do
		rendered.should have_content("#{session[:login]} logged")
	end		
end

