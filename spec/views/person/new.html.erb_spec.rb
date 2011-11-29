require 'spec_helper'

describe "person/new.html.erb" do
	before(:each) do
		@person1 = stub_model(Person, :name => "nom", :firstname => "prenom", :password => "Password", :login => "Login")
		render
	end
	
	it "displays parameters of a Person" do
		rendered.should have_content('Creation d\'un nouvel utilisateur')
		rendered.should have_content('Nom')
		rendered.should have_content('Prenom')
		rendered.should have_content('Password ')
		rendered.should have_content('Login/Pseudo')
	end
	
	it "should display a form with method post" do        
		rendered.should have_selector("form", :method => "POST")
	end
	
	it "should have textfield for parameters of a Person" do
		rendered.should have_selector("input",:type => "text", :name => "nom")
		rendered.should have_selector("input",:type => "text", :firstname => "prenom")
		rendered.should have_selector("input",:type => "text", :password => "Password")        
		rendered.should have_selector("input",:type => "text", :login => "Login")
	end
	
	it "should have a button to validate the creation of the Person" do	
		rendered.should have_selector("input", :type => "submit", :name => "Creer utilisateur")
		rendered.should have_button("Creer utilisateur")
	end
	
	it "should have a button to go at home page displaying 'Page d'accueil'" do
		rendered.should have_selector("input", :type => "submit", :name => "Page d'accueil", :href => posts_path) 
		rendered.should have_button("Page d'accueil")
	end 	
end




