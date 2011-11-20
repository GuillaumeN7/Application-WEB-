require 'spec_helper'
describe PersonController do

	describe "POST 'createUser'" do
	   it "should redirect to the todo list" do
		 post :createUser
		 response.should redirect_to posts_path
	   end
	 end
	 
	describe "POST 'createUser'" do
		before(:each) do
			@new_person_params = {"person" => {"name" => "person_name", "firstname" => "person_firstname","password" => "person_password", "login" => "person_login"}}
			@person = stub_model(Person)
			Person.stub(:new) {@person}
		end

	   it "should create a new User with the given params" do
			Person.should_receive(:new)
			post :createUser, @new_person_params
	   end

	   it "should redirect to posts_path" do
			post :createUser, @new_person_params
			response.should redirect_to posts_path
	  	end
	end
end
