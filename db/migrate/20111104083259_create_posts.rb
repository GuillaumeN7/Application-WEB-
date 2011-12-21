class CreatePosts < ActiveRecord::Migration
	def change
		create_table :posts do |t|
			t.integer :person_id
			t.string :title
			t.text :body
			t.timestamps
		end   
	end
end
