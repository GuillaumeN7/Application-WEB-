class Note < ActiveRecord::Base
	belongs_to :post
	validates :note, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 5 }
end
