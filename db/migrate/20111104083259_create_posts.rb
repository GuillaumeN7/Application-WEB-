class CreatePosts < ActiveRecord::Migration
	def change
		create_table :posts do |t|
			t.string :title
			t.text :body
			t.timestamps
		end
		add_column :posts, :person_id, :integer    
	end
end
