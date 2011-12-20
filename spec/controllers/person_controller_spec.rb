require 'spec_helper'
describe PersonController do

	describe "POST 'create'" do
		before(:each) do
			@new_person_params = {"person" => {"name" => "person_name", "firstname" => "person_firstname","password" => "person_password", "login" => "person_login"}}
			@person = stub_model(Person)
			Person.stub(:new) {@person}
		end

		it "should create a new User with the given params" do
			Person.should_receive(:new)
			post :create, @new_person_params
		end

		it "should redirect to posts_path" do
			post :create, @new_person_params
			response.should redirect_to posts_path
	  	end
	end

	describe "GET 'new'" do
	
	end

	# Cas ou Javascript utilise : on appelle la page Login dans posts_path
	describe "GET 'connect'" do
	
	end
	
	# Cas ou Javascript desactive : une fenetre est integree dans la page posts_path
	describe "POST 'connect'" do
		before(:each) do
	#		@person = Person.create(:login => "Froz", :name => "CAEN", :firstname => "Guillaume", :password => "secret", :id => "31")
			@person = stub_model(Person, :login => "Froz", :name => "CAEN", :firstname => "Guillaume", :password => "secret", :id => "31")
			@person_param = {"person" => {"password" => "person_password", "login" => "person_login"}}				
			Person.stub(:find_by_login_and_password).with(@person.login, @person.password)
	#		post :connect, :login => @person.login, :password => @person.password
			post :connect, @person_param
		end
		
		it "should search the person" do
			Person.should_receive(:find_by_login_and_password).with(@person.login, @person.password).and_return(@pers)
		end
		
		it "should log the user" do
#			post :connect, :person => { :login => @person.login, :password => @person.password}
			assert_equal @person.id, session[@person.id]
			response.should redirect_to posts_path
		end
	end

end
