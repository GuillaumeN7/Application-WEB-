require 'spec_helper'

describe "post/accessModify.html.erb" do
	before(:each) do
		@post1 = stub_model(Post, :title => "Comment va", :body => "Ca va bien et toi", :id => "17")		
		assign(:post, @post1)
#		controller.request.path_parameters[:id] = @post1.id
		render
	end

	it "should have a button named 'Valider' for validate the change of the post" do
		rendered.should have_selector("input", :type => "submit", :name => "Valider", :href => modify_path(@post1.id)) 
		rendered.should have_button("Valider")
	end    	
	
	it "displays a textfield 'Consultation du post :' with value = 'post.title' and a textareafield 'Message :' with value = 'post.body' " do
		rendered.should have_selector("input", :type => "text") 
		rendered.should have_content('Modification du post')
		rendered.should =~ /#{@post1.title}/					
		rendered.should have_selector('input', :content => @post1.title)	
		rendered.should have_content('Message : ')
		rendered.should have_selector("textarea", :content => @post1.body) 
		rendered.should =~ /#{@post1.body}/					
	end	
end


describe "post/accessModify.html.erb" do
	before(:each) do	
		@post1 = stub_model(Post, :title => "Comment va", :body => "Ca va bien et toi", :id => "17")		
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
