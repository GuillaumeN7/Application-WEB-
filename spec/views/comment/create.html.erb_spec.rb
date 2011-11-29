require 'spec_helper'

describe "comment/create.html.erb" do
	before(:each) do
    		@post1 = stub_model(Post)
    		controller.request.path_parameters[:id] = @post1.id 
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
       	rendered.should have_selector("input", :type => "submit", :name => "Valider", :href => showComment_path)   	
    end
    
    it "should have a button to go at home page" do
       	rendered.should have_selector("form",:method => "get")    
       	rendered.should have_selector("input", :type => "submit", :name => "Page d'accueil", :href => posts_path) 
      	rendered.should have_button("Page d'accueil")
    end   
end




