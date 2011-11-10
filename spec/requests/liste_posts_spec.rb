require 'spec_helper'

describe "PostListings" do
	before (:each) do
		@post1 = Post.create(:title => "sujet1", :body => "bla bla")
		@post2 = Post.create(:title => "sujet2", :body => "bla bla")
		visit posts_path
	end

	describe "GET /posts" do
		it "generates a listing of posts" do
			page.body.should include(@post1.title)
			page.body.should include(@post2.title)
		end
		it "verify ClickButtonPresence" do
			page.has_xpath?('//input[@id="Add New Post"]')
			click_on('Add New Post')
		end
		it "After Click go on posts/new" do
		current_path.should == "posts/new"
		end
			
	end

end

