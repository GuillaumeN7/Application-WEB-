require 'spec_helper'

# User not logged
describe "post/index.html.erb" do
	before(:each) do	
		@post1 = stub_model(Post, :title => "sujet1")
		@post2 = stub_model(Post, :title => "sujet2")
		@posts = [@post1, @post2]		
		render
	end	

	it "display number of post and title" do
		rendered.should =~ /sujet1/
		rendered.should =~ /#{@post1.title}/
		rendered.should =~ /sujet2/				
		rendered.should =~ /#{@post2.title}/
	end

    	it "should not have a button named 'Add New Post' for create a post" do
		rendered.should have_selector("input", :type => "submit", :name => "Add New Post", :href => posts_new_path) 
		rendered.should_not have_button("Add New Post")
	end
	
	it "display 'Affichage des posts', not display'Creation des posts' and 'Nouveau Post :'" do
		rendered.should have_content('Affichage de la liste des posts')
		rendered.should_not have_content('Creation d\'un nouveau post')
	end
	
	it "should have ul li in page to display listing of posts" do
		rendered.should have_selector "ul li"
		rendered.should have_selector "li:contains('#{@post1.title}')"
		rendered.should have_selector "li:contains('#{@post2.title}')"
	end
	
	it "should display a link with 'id = post.id' to read the post" do
		@posts.each do |p|	
			rendered.should have_link("#{p.id}", :href => consult_path(p.id))
		end  	
	end
	  
	it "should have a button 'supprimer' by post" do
	  	rendered.should have_button("Supprimer")
		@posts.each do |p| 	
		  	rendered.should have_selector("input", :type => "submit", :href => delete_path(p.id))
		end 	         		  	  	  	
	end		
end

#describe "post/index.html.erb" do
#	before(:each) do	
#		@post1 = stub_model(Post, :title => "sujet1")
#		@post2 = stub_model(Post, :title => "sujet2")
#		@posts = [@post1, @post2]	
#		render
#	end		
#	it "should display a window to permit the authentication after visit login_path" do
#		rendered.should have_content('Connexion')	
#		rendered.should have_content('Login')
#		rendered.should have_content('Password')
#		rendered.should have_button("Connexion")
#	end				
#end

#User logged
describe "post/index.html.erb" do
	before(:each) do	
		@post1 = stub_model(Post, :title => "sujet1")
		@post2 = stub_model(Post, :title => "sujet2")
		@posts = [@post1, @post2]
		@person = stub_model(Person, :login => "capybara")			
		session[:id] = @person.id
		session[:login] = @person.login				
		render
	end	
	
	it "should not have a button 'supprimer' by post" do
	  	rendered.should_not have_button("Supprimer")
		@posts.each do |p| 	
		  	rendered.should have_selector("input", :type => "submit", :href => delete_path(p.id))
		end     	         		  	  	  	
	end		

	it "should display 'Bienvenue <%= session[:login] %>' if user logged" do
		rendered.should have_content("Bienvenue #{session[:login]}")
	end

    	it "should have a button named 'Add New Post' for create a post" do
		rendered.should have_selector("input", :type => "submit", :name => "Add New Post", :href => posts_new_path) 
		rendered.should have_button("Add New Post")
	end
	
	it "display 'Affichage des posts', display'Creation des posts' and 'Nouveau Post :'" do
		rendered.should have_content('Affichage de la liste des posts')
		rendered.should have_content('Creation d\'un nouveau post')
	end
	
	it "should not display a window to permit the authentication if already logged" do
		rendered.should_not have_content('Connexion')	
		rendered.should_not have_content('Login')
		rendered.should_not have_content('Password')
		rendered.should_not have_button("Connexion")
	end	
	
	it "should have a link 'Deconnexion'" do
		rendered.should have_link("Deconnexion")
	end	
	
	it "should have button 'Page des utilisateurs'" do
		rendered.should have_button("Page des utilisateurs")
		rendered.should have_content("Utilisateurs")
	end
		
end
	
	
	
	
	
	
	
	
