require 'spec_helper'

describe "post/index.html.erb" do
		assign(:posts, [
			stub_model(Post, :title => "sujet1"),
			stub_model(Post, :title => "sujet2")
		])
	render
	
	rendered.should =~ /sujet1/
	rendered.should =~ /sujet2/



end



