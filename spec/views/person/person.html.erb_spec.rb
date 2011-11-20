require 'spec_helper'

describe "person/newUser.html.erb" do
    it "displays a form to create a new user" do
    newperson = mock_model("Person", :name => "nom", :firstname => "prenom", :password => "Password", :login => "Login").as_new_record
    assign(:person, newperson)

        render
        rendered.should =~ /name/
        rendered.should =~ /firstname/
        rendered.should =~ /password/
        rendered.should =~ /login/
        
        rendered.should have_content('Creation d\'un nouvel utilisateur')
        rendered.should have_content('Nom')
        rendered.should have_content('Prenom')
        rendered.should have_content('Password ')
        rendered.should have_content('Login/Pseudo')        
        rendered.should have_selector("form", :method => "POST")
        rendered.should have_selector("input",:type => "text", :name => "nom")
        rendered.should have_selector("input",:type => "text", :firstname => "prenom")
        rendered.should have_selector("input",:type => "text", :password => "Password")        
        rendered.should have_selector("input",:type => "text", :login => "Login")
       	rendered.should have_selector("input", :type => "submit", :name => "Creer utilisateur")
    end
end




