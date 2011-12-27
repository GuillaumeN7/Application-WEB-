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

	describe "POST 'connect'" do
		before(:each) do
			@person = stub_model(Person, :login => "Froz", :name => "CAEN", :firstname => "Guillaume", :password => "secret", :id => "31")			
			Person.stub(:find_by_login_and_password).with(@person.login, @person.password)
		end
		
		it "should search the person" do
			Person.should_receive(:find_by_login_and_password).with(@person.login, @person.password).and_return(@pers)
			post :connect, {:login => @person.login, :password => @person.password}		
			assigns(:person).should eq @pers
			#response.should be_success				
			assert_equal nil, session[:id]
		end
	end
		
	describe "POST 'connect'" do		
		it "should unhautorize the authentication" do
			@person = stub_model(Person, :login => "Froz", :name => "CAEN", :firstname => "Guillaume", :password => "secret", :id => "31")		
			Person.stub(:find_by_login).with(@person.login)
			Person.should_receive(:find_by_login).with(@person.login).and_return(@pers)		
			post :connect, :login => @person.login
			assigns(:person).should eq @pers	
			controller.session[:id] = @person.id
			assert_equal @person.id, session[:id]
		end
	end
	
	describe " 'logout'" do		
		before(:each) do
			@person = stub_model(Person, :login => "Froz", :name => "CAEN", :firstname => "Guillaume", :password => "secret", :id => "31")		
			session[:id]=@person.id	
			session[:name]=@person.name
			session[:firstname]=@person.firstname	
			session[:password]=@person.password
		end
		it "should logout the user and redirect_to posts_path" do
			get :logout, {:id => @person.id }	
			assert_equal nil, session[:id]
			assert_equal nil, session[:password]
			assert_equal nil, session[:firstname]
			assert_equal nil, session[:name]									
			response.should redirect_to posts_path			
		end
	end
end
