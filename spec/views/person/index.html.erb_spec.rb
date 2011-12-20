require 'spec_helper'

describe "person/index.html.erb" do
	before(:each) do
		@person1 = stub_model(Person, :name => "CAEN", :firstname => "Guillaume", :password => "1", :login => "froz")
		@person2 = stub_model(Person, :name => "PEREC", :firstname => "Marie Jose", :password => "2", :login => "sportive")		
		@person3 = stub_model(Person, :name => "ZETA JONES", :firstname => "Catherine", :password => "3", :login => "actrice")		
		@people = [@person1, @person2, @person3]		
		render
	end
	
	it "displays 'Affichage des utilisateurs'" do
		rendered.should have_content('Affichage des utilisateurs')
		rendered.should have_content('Creation d\'un nouvel utilisateur')
	end
	
	it "should have a button to go at home page displaying 'Page d'accueil'" do
		rendered.should have_selector("input", :type => "submit", :name => "Page d'accueil", :href => posts_path) 
		rendered.should have_button("Page d'accueil")
	end 	
	
	it "should display the listing of user (firstname and login)" do
		@people.each do |p|	
			rendered.should have_content("#{p.firstname} alias #{p.login}")
		end  	
	end	

	it "should display the listing of user (firstname and login)" do
		rendered.should have_content("#{@person1.firstname} alias #{@person1.login}")
		rendered.should have_content("#{@person2.firstname} alias #{@person2.login}")
		rendered.should have_content("#{@person3.firstname} alias #{@person3.login}")				
	end		
	
	it "should have a button create a new user" do
		rendered.should have_selector("input", :type => "submit", :name => "Creer un utilisateur", :href => newUser_path) 
		rendered.should have_button("Creer un utilisateur")
	end 
	
end




