class Post < ActiveRecord::Base
	has_many :comments, :dependent => :destroy
	has_many :notes, :dependent => :destroy	
	belongs_to :person
	validates :title, :presence => true
	validates :body, :presence => true	
end
