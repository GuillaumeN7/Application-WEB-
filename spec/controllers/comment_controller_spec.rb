require 'spec_helper'
describe CommentController do

	describe "POST 'create'" do
		before(:each) do
			@post = Post.create(:title => "lala", :body => "lili", :id => "100")
			@commentaire = stub_model(Comment, :author => "Guillaule", :body => "aha", :id => 1, :post_id => @post.id)
			Comment.stub(:new) {@commentaire}
		end

		it "should create a new Post with the given params" do
			Comment.should_receive(:new)
			post :create, {:id => @post.id}
		end

		it "should redirect to post's view" do
			post :create, {:id => @post.id}
			response.should redirect_to consult_path(@post.id)
		end		
	end
	
	describe "POST 'new'" do
		it "should find the post which will own the comment" do
			@post = Post.create(:title => "lala", :body => "lili", :id => "100")			
			Post.stub(:find) {@post.id}
			Post.should_receive(:find).and_return(@postR)
			get 'new', {:id => @post.id}								
			assigns(@post).should eq @postR
			response.should be_success
		end
	end
	
	describe "GET 'edit'" do
		before(:each) do
			@post = Post.create(:title => "lala", :body => "lili", :id => "100")			
			@comment = Comment.create(:author => "Guillaume", :body => "corps du commentaire", :post_id => @post.id, :id => "66") 
		end
	
		it "should find the post which will own the comment" do
			Post.stub(:find) {@post.id}
			Post.should_receive(:find).and_return(@postR)
			get 'new', {:id => @post.id}								
			assigns(@post).should eq @postR
			response.should be_success
		end
		
		it "should find the comment owned by @post" do
			@post.comments.stub(:find){ @comment.id }		
			get 'edit', {:id => @post.id, :comment_id => @comment.id}
		end
	end

	describe "PUT 'modify'" do
		before(:each) do
			@person = Person.create(:login => "a", :password =>"b", :name => "c", :firstname => "d")
			session[:id] = @person.id		
			@post = Post.create(:title => "Titre du Com", :body => "yihaaaa", :id => "1")						
			@comment = Comment.create(:author => "guillaume", :body => "Ceci est un com", :post_id => @post.id, :id => "17" )										
			@comment.stub(:save){ true }
			Post.stub(:find){ @post }			
			@post.comments.stub(:find){ @comment }								
		end
		
		it "should redirect to the @post view" do
			put :modify, {:id => @comment.post_id, :comment_id => @comment.id}	
			response.should redirect_to consult_path(@post.id)
		end
		
		it "should modify the post" do
			put :modify, {:id => @comment.post_id, :comment_id => @comment.id}	
		end		
	end
	
	describe "DELETE 'destroy'" do	
		before(:each) do
			@person = Person.create(:login => "a", :password =>"b", :name => "c", :firstname => "d")
			session[:id] = @person.id		
			@post = Post.create(:title => "Titre du Com", :body => "yihaaaa", :id => "1")						
			@comment = Comment.create(:author => "guillaume", :body => "Ceci est un com", :post_id => @post.id, :id => "17" )										
			@comment.stub(:destroy){ true }
			Post.stub(:find){ @post }			
			@post.comments.stub(:find){ @comment }						
		end
		
		it "should redirect to the @post view" do
			delete :destroy, {:id => @comment.post_id, :comment_id => @comment.id}	
			response.should redirect_to consult_path(@post.id)
		end
		
		it "should destroy the post" do
			Comment.should_receive(:destroy)
			delete :destroy, {:id => @comment.post_id, :comment_id => @comment.id}	
		end
	end
end
