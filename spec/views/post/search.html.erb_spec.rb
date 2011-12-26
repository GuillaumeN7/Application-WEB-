require 'spec_helper'

describe "post/search.html.erb" do
	before(:each) do	
		@person1 = Person.create(:name => "a", :firstname => "aa", :login => "capybara", :password => "aaAzeaz")
		@person2 = Person.create(:name => "a", :firstname => "aa", :login => "capybara2222", :password => "aaAzeaz")			
		@post1 = stub_model(Post, :person_id => @person1, :title => "sujet1", :updated_at => "2011-10-23 12:17:47")
		@post2 = stub_model(Post, :person_id => @person2, :title => "sujet2", :updated_at => "2011-11-18 19:01:00")
		@post3 = stub_model(Post, :person_id => @person2, :title => "sujet3", :updated_at => DateTime.now)		
		@posts = [@post1, @post2, @post3]		
		render
	end	

	it "should display 'Mot(s) ou morceau de message :' and 'Auteur :' and 'Titre :' and 'Recherche de message(s)'" do
		rendered.should have_content('Mot(s) ou morceau de message :')
		rendered.should have_content('Auteur :')
		rendered.should have_content('Titre :')		
		rendered.should have_content('Recherche de message(s)')
	end 
	
	it "should have a button to go at home page displaying 'Page d'accueil'" do
		rendered.should have_selector("input", :type => "submit", :name => "Page d'accueil", :href => posts_path) 
		rendered.should have_button("Page d'accueil")
	end 
	
#	it "should display a link with 'id = post.id' to read the post" do
#		@posts.each do |p|	
#			rendered.should have_link("#{p.id}", :href => consult_path(p.id))
#		end  	
#	end

#	it "should display the author of post after link post" do
#		@posts.each do |p|	
#			rendered.should have_content("#{p.title}")
#			rendered.should =~ /[Auteur : #{Person.find_by_id(p.person_id).login}]/			
#		end 
#	end
			
end

