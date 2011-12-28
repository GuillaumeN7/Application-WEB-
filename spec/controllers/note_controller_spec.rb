require 'spec_helper'
describe NoteController do
	describe "POST 'saveNote'" do
		before(:each) do
			#-------------------------------------on authentifie l'user----------------------------------
			@person = Person.create(:login => "froz312", :name => "Caen", :firstname => "Guillaume", :password => "2", :id => "1")
			@person2 = Person.create(:login => "bb", :name => "a", :firstname => "b", :password => "2", :id => "2")
			@person3 = Person.create(:login => "aa", :name => "b", :firstname => "a", :password => "2", :id => "3")
			@person4 = Person.create(:login => "cc", :name => "cc", :firstname => "cc", :password => "cc", :id => "4")		
			session[:id] = @person.id
			Person.stub(:find_by_id){session[:id]}
			session[:id].should eq @person.id
			
						
			#----------------------------- On a besoin d'un post pour le noter----------------------------
			@post1 = Post.create(:person_id => @person.id, :title => "test", :body => "test", :note_post => "3")

			@note = Note.create(:note => "5", :person_id => @person2.id, :post_id => @post1.id)
			@note2b = Note.create(:note => "1", :person_id => @person3.id, :post_id => @post1.id)
			@note3 = Note.create(:note => "2", :person_id => @person4.id, :post_id => @post1.id)
	  		@note2 = stub_model(Note, :note => "4", :person_id => session[:id], :post_id => @post1.id)
	  		@notes = [@note, @note2b, @note3, @note2]	  
		end
		
		it "should search the post" do		
			Post.stub(:find) {@post1}
			Post.should_receive(:find)	
			post :saveNote, {:id => @post1, :note => @note.note}		
			response.should redirect_to consult_path(@post1)							
		end		
		
		it "should create a note for @post and save it." do
			@noteAJourdePost1 = (@note.note + @note2b.note + @note3.note + @note2.note) / 4 
			Post.stub(:find){@post1}
			Note.stub(:new) {@note2}
			Note.stub(:find_all_by_post_id) {@post1}
			Post.should_receive(:find)
			Note.should_receive(:new)
			@post1.stub(:save) {@note2}
			@note2.should_receive(:save)
			post :saveNote, {:id => @post1, :note => @note2.note}
			#la nouvelle note est la moyenne des 3 existantes + la nouvelle passee en parametre
			@post1.note_post.should eq @noteAJourdePost1
			response.should redirect_to consult_path(@post1)
		end
	end
end







