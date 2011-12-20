class Person < ActiveRecord::Base
	has_many :posts	
	validates_presence_of	:name
	validates_uniqueness_of	:name
	validates_presence_of	:firstname
	validates_uniqueness_of	:firstname
	validates_presence_of	:login
	validates_uniqueness_of	:login
	validates_presence_of	:password			
end
