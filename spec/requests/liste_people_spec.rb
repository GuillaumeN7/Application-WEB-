require 'spec_helper'

describe "PeopleListings" do
	before (:each) do
		@person1 = Person.create(:login => "Guillaume", :name => "aa", :firstname => "bb", :password => "2", :id => "17")
		@person2 = Person.create(:login => "Capybara", :name => "aa", :firstname => "5456", :password => "4578_14", :id => "18")
		visit listingPeople_path
	end
	describe "GET /people" do
	
		it "should display 'AFFICHAGE DES UTILISATEURS' and 'CREATION D'UN NOUVEL UTILISATEUR'" do
			page.should have_content('Affichage des utilisateurs ')
			page.should have_content('Creation d\'un nouvel utilisateur')
		end			
		
		it "generates a listing of people" do
			page.body.should include(@person1.firstname)
			page.body.should include(@person1.login)
			page.body.should include(@person2.firstname)
			page.body.should include(@person2.login)
		end
		
		it "verify ClickButtonPresence 'Creer un utilisateur'" do
			page.should have_button ('Creer un utilisateur') 
			click_button('Creer un utilisateur')
		end
		
		it "After Click go on people/new" do
			click_button('Creer un utilisateur')
			current_path.should == newUser_path
		end
		
		it "verify ClickRetourPageAcceuilPresence" do
			page.should have_button('Page d\'accueil')	
			click_button('Page d\'accueil')
			current_path.should == posts_path		
		end			
	end
end
#-------------------------------------------------------------
describe "PeopleCreation" do
	before (:each) do
		@person1 = Person.create(:login => "Guillaume", :name => "aa", :firstname => "bb", :password => "2", :id => "17")
		@person2 = Person.create(:login => "Capybara", :name => "aa", :firstname => "5456", :password => "4578_14", :id => "18")
		visit newUser_path
	end
	describe "GET /people/new" do	
		it "verifyCurrentPath" do
			current_path.should == newUser_path
		end	
		it "verifyClickButton 'Creer utilisateur' Presence" do
			page.should have_button('Creer utilisateur')		
			click_on('Creer utilisateur')
		end
		it "verifyPresenceFormulaireAvecTitleEtBody" do
			page.should have_selector('form')
			page.should have_field('name')
			page.should have_field('firstname')
			page.should have_field('login')
			page.should have_field('password')
			page.should have_button('Creer utilisateur')		
		end
		it "filling Fields And Create User" do
			fill_in('name', :with => 'Guillaume')
			fill_in('firstname', :with => 'CAEN')
			fill_in('login', :with => 'lalala')
			fill_in('password', :with => 'jipazep_jyryer')					
			click_button('Creer utilisateur')
			current_path.should == posts_path
			page.should have_content("201 USER Guillaume CAEN alias lalala CREATED")
		end
		it "verify ClickRetourPageAcceuilPresence" do
			page.should have_button('Page d\'accueil')	
			click_button('Page d\'accueil')
			current_path.should == posts_path		
		end			
	end
end
#---------------------------------------------------------------------------------
describe "PeopleLogin" do
	describe "GET /people/connect" do
		before (:each) do
			@person1 = Person.create(:login => "Testeur", :name => "aa", :firstname => "bb", :password => "surprise", :id => "1")
			visit login_path
		end
		
		it "should display a form with login and password fields" do
			page.should have_selector('form')
			page.should have_field('login')
			page.should have_content("Login :")			
			page.should have_field('password')	
			page.should have_content("Password :")
			page.should have_button("Connexion")
		end	
		
		it "should log the user '@person1.login' with password '@person1.password' and redirect to posts_path" do
			fill_in('login', :with => @person1.login)
			fill_in('password', :with => @person1.password)
			click_button("Connexion")
			current_path.should == posts_path
		end		
	end
end
#---------------------------------------------------------		
describe "PeopleLogout" do
	before (:each) do
			@person1 = Person.create(:login => "Testeur", :name => "aa", :firstname => "bb", :password => "surprise", :id => "2")
		visit login_path
		fill_in('login', :with => @person1.login)
		fill_in('password', :with => @person1.password)
		click_button("Connexion")		
	end

	it "should display a link 'Deconnexion' and 'Bienvenue '@person1.login'" do
		current_path.should == posts_path
		page.should have_content("Bienvenue #{@person1.login}")
		page.should have_link("Deconnexion")						
	end		
	
	it "should logout @person1 after click link 'Deconnexion''" do
		click_link("Deconnexion")	
		current_path.should == posts_path		
		page.should have_content("Deconnexion terminee. Merci de votre visite")				
	end		

end










