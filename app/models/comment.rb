class Comment < ActiveRecord::Base
  belongs_to :posts, :foreign_key => "posts_id"
end



