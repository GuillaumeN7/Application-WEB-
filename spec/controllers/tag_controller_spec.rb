require 'spec_helper'
describe TagController do
	describe "POST 'tag'" do
		before(:each) do
			@person = Person.create(:login => "froz312", :name => "Caen", :firstname => "Guillaume", :password => "2", :id => "1")
			
			Person.stub(:find_by_id){session[:id]}						
			@post = Post.create(:person_id => @person.id, :title => "test", :body => "test", :note_post => "")
			@tag = stub_model(Tag, :post_id => @post.id, :person_id => @person.id)  
		end
		
		it "should tag fail because nobody logged and redirect_to posts_path" do
			post :tagPost, {:id => @post.id}	
			response.should_not be_success
			response.should redirect_to posts_path
			flash[:notice].should eq "Il est necessaire d'etre connecte pour effectuer cette action"
		end
		
		it "should be log" do
			session[:id] = @person.id
			session[:id].should eq @person.id
		end
		
		it "should search the post" do		
			session[:id] = @person.id
			Post.stub(:find).with(@post.id.to_s).and_return(@post)
			Post.should_receive(:find).and_return(@post)	
			post :tagPost, {:id => @post.id}		
			assigns[:post].should eq @post
			response.should redirect_to consult_path(@post)							
		end	
		
		it "should create @tag and save it." do
			session[:id] = @person.id
			Tag.stub(:new) { @tag }
			@tag.stub(:save)
			Tag.should_receive(:new).and_return(@tag)
			@tag.should_receive(:save)
			post :tagPost, {:id => @post.id}		
			response.should redirect_to consult_path(@post)
		end			
		
		it "should tag the post and notify user with flash[:notice]." do
			session[:id] = @person.id
			post :tagPost, {:id => @post.id}		
			response.should redirect_to consult_path(@post)
			flash[:notice].should eq "Le post a ete tagge avec succes"
		end
	end
	#--------------------------------------------------------------------------------------------------------------------------
	describe "POST 'detag'" do
		before(:each) do
			@person = Person.create(:login => "froz312", :name => "Caen", :firstname => "Guillaume", :password => "2", :id => "1")			
			Person.stub(:find_by_id){session[:id]}						
			@post = Post.create(:person_id => @person.id, :title => "test", :body => "test", :note_post => "")
			@tag = Tag.create(:post_id => @post.id, :person_id => @person.id)  
		end
		
		it "should detag fail because nobody logged and redirect_to posts_path" do
			post :deTagPost, {:id => @post.id}	
			response.should_not be_success
			response.should redirect_to posts_path
			flash[:notice].should eq "Il est necessaire d'etre connecte pour effectuer cette action"
		end
		
		it "should be log" do
			session[:id] = @person.id
			session[:id].should eq @person.id
		end
		
		it "should search the post" do		
			session[:id] = @person.id
			Post.stub(:find).with(@post.id.to_s).and_return(@post)
			Post.should_receive(:find).and_return(@post)	
			post :deTagPost, {:id => @post.id}		
			assigns[:post].should eq @post
			response.should redirect_to consult_path(@post)							
		end	
		
		it "should search the tag associated at @post" do		
			session[:id] = @person.id
			Tag.stub(:find_by_post_id_and_person_id).with(@post.id, session[:id]).and_return(@tag)
			Tag.should_receive(:find_by_post_id_and_person_id).and_return(@tag)	
			post :deTagPost, {:id => @post.id}		
			assigns[:tag].should eq @tag
			response.should redirect_to consult_path(@post)							
		end	
		
		it "should destroy the tag" do
			session[:id] = @person.id
			@tag.stub(:destroy)
			post :deTagPost, {:id => @post.id}	
			response.should redirect_to consult_path(@post)
			flash[:notice].should eq "Le post a ete detagge avec succes"
		end
	end
end







