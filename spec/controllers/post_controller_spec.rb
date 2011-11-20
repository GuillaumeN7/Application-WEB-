require 'spec_helper'
describe PostController do
	describe "GET 'index'" do
		before(:each) do
			@posts = [stub_model(Post,:title => "1"), stub_model(Post, :title => "2")]
			Post.stub(:all){ @posts }
		end
		it "assigns a list of posts" do
			Post.should_receive(:all).and_return(@posts)
			get 'index'
			assigns(:posts).should eq @posts
			response.should be_success
		end
		it "renders the template list" do
			get 'index'
			response.should render_template(:index)
		end

	end

	describe "POST 'new'" do
	end


	describe "DELETE 'delete_path'" do
		before(:each) do
		  @post = stub_model(Post, :id => 4)
		  @post.stub(:destroy){ true }
		  Post.stub(:find){@post}
		end
		it "should destroy and redirect to the posts list" do
		  delete :destroy, {:id => @post.id }
		  response.should redirect_to posts_path
		end
	end		
	
	describe "POST 'create'" do
	   it "should redirect to the todo list" do
		 post :create
		 response.should redirect_to posts_path
	   end
	 end

	describe "POST 'create'" do
		before(:each) do
			@new_post_params = {"post" => {"title" => "post_title", "body" => "post_body"}}
			@post = stub_model(Post)
			Post.stub(:new) {@post}
		end

	   it "should create a new Post with the given params" do
			Post.should_receive(:new)
			post :create, @new_post_params
	   end

	   it "should redirect to posts_path" do
			post :create, @new_post_params
			response.should redirect_to posts_path
	  	end
	end
end
