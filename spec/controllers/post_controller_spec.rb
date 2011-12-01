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

	describe "DELETE 'delete_path'" do
		before(:each) do
			@post = Post.create(:title => "Titre du Com", :body => "yihaaaa", :id => "4")
			Post.stub(:find){@post}
			@post.stub(:destroy){ true }

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
	
	describe "PUT 'modify'" do
		before(:each) do
			@post = Post.create(:title => "ey", :body => "et encore un petit pour la route!", :id => "31")
				# "Post.stub(:all) { @post }"  <=> "Post.all(params[:id]) (ou @post.id ou @post qui comprend qu'on veut l'id)"
				 # Le stub image la méthode all faite dans le post_controller.rb.
			Post.stub(:all){ @post }	 				
			@comment1 = stub_model(Comment, :author => "Guigui", :body => "aha", :id => 1, :post_id => @post.id)
			@comment2 = stub_model(Comment, :author => "Pibi", :body => "oho", :id => 2, :post_id => @post.id)
			@comment3 = stub_model(Comment, :author => "Oxy", :body => "ihi", :id => 3, :post_id => @post.id)
			@commentaires = [@comment1, @comment2, @comment3]
				# Même principe que ci-dessus sauf qu'on a cette fois dans le controlleur "@comments = Comment.find_all_by_post_id(params[:id])"
				 # Le principe est que l'on simule l'exécution de ces 2 méthodes et on va tester après qu'elles ont fonctionnées.
			Comment.stub(:find_all_by_post_id) {@post.id}									
		end

		it "assigns a list of comment" do
			Comment.should_receive(:find_all_by_post_id).and_return(@comments)
			get 'read', {:id => @post.id}								
			assigns(:commentaires).should eq @comments
			response.should be_success
		end

#TEST CI DESSUS COMMENTE
				# Ici on vérifie qu'on reçoit bien la méthode "find_all_by_post_id" simulé dans le 'before(:each)'
				 # Les éléments trouvés sont alors renvoyés dans '@comments'
#			Comment.should_receive(:find_all_by_post_id).and_return(@comments)
				# On va à la page posts/:@post.id							   
#			get 'read', {:id => @post.id}								
				# On va ici vérifier que la réponse '@comments' (juste même nom que le @comments ci dessus) retournée par le controleur est bien ce qu'on attend, 
				 # en l'occurence '@commentaires' qu'on à crée dans le before.
#			assigns(:commentaires).should eq @comments


	end
	
	describe "GET 'read'" do
	
	end
end
