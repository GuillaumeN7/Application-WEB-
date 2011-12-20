require 'spec_helper'

describe "post/new.html.erb" do
	before(:each) do	
		@post1 = stub_model(Post, :title => "title", :body => "body")
		render
	end	
	
    it "displays a textfield named post[title] and a textareafield named post[body] " do
		rendered.should have_selector("input",:type => "text", :name => @post1.title)
   		rendered.should have_selector("textarea", :name => @post1.body) 
	end
	
	it "should have a button named Valider" do
	   	rendered.should have_selector("input", :type => "submit", :name => "Valider", :href => createPost_path)  
 	   	rendered.should have_button("Valider")	   		   	
	end

	it "should have some contents" do
		rendered.should have_content('Creation d\'un nouveau Post')
		rendered.should have_content('Titre')
		rendered.should have_content('Message')
	end
	
end
describe "post/new.html.erb" do
	before(:each) do	
		@post1 = stub_model(Post, :title => "rerrrrrr", :body => "azeazeaze", :id => "12")		
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

