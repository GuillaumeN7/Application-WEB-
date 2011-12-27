require 'spec_helper'
describe NoteController do
	describe "POST 'saveNote'" do
		before(:each) do
			@person = Person.create(:login => "froz312", :name => "Caen", :firstname => "Guillaume", :password => "2", :id => "1")
			session[:id] = @person.id
			@post = Post.create(:person_id => @person.id, :title => "test", :body => "test", :id => "2", :note_post => "")
	  		@note = stub_model(Note, :note => "3", :person_id => session[:id], :post_id => @post.id)
	  #		@note = stub_model(Note)
			#Post.stub(:find){@post.id}.and_return(@postreturn)
	#		Note.stub(:new) {@note}
		
		end
		
		it "should search the post" do
		
			Post.stub(:find){@post.id}
			Post.should_receive(:find)	
			post :saveNote, {:id => @post.id, :note => "3"}		
			assigns(:person).should eq @postreturn
			response.should redirect_to consult_path(@post.id)							
		end		
		
		it "should create a note for @post." do
#			Post.stub(:find){@post.id}.and_return(@postreturn)
			Note.stub(:new) {@note}
			Note.stub(:find) {@post.id}
			@post.stub(:save) {@note}
			post :saveNote, {:id => @post.id, :note => "3"}
			response.should redirect_to consult_path(@post.id)
		end
	end
end







