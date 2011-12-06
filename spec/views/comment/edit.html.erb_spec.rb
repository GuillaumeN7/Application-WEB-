require 'spec_helper'

describe "comment/edit.html.erb" do
	before(:each) do	
		@post1 = stub_model(Post, :title => "titre du post", :body => "corps du post", :id => "24")
		@comment1 = stub_model(Comment, :author => "Guillaume", :body => "com pour le test de la vue", :post_id =>@post1.id)		
		assign(:post, @post1)
		assign(:comment, @comment1)	
		render
	end

	it "should have a button named 'Valider' for validate the modification of the post" do
		rendered.should have_selector("input", :type => "submit", :name => "Valider", :href => modifyCom_path(@post1.id,@comment1.id)) 
		rendered.should have_button("Valider")
	end

	it "should have a button to go at home page displaying 'Page d'accueil'" do
		rendered.should have_selector("input", :type => "submit", :name => "Page d'accueil", :href => posts_path) 
		rendered.should have_button("Page d'accueil")
	end 
    
    	it "should have a button named 'Supprimer' for delete the commentaire" do
		rendered.should have_selector("input", :type => "submit", :name => "Supprimer", :href => deleteCom_path(@comment1.post_id,@comment1.id)) 
		rendered.should have_button("Supprimer")
	end

    	it "should have a button named 'Precedent' for come back a the @post1 page of the commentaire" do
		rendered.should have_selector("input", :type => "submit", :name => "Precedent", :href => consult_path(@comment1.id)) 
		rendered.should have_button("Precedent")
	end	
	
end




