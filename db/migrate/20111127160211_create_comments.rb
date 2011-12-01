class CreateComments < ActiveRecord::Migration
	def change
		create_table :comments do |t|
			t.string :author
			t.text :body
			t.timestamps
		end
		add_column :comments, :post_id, :integer
	end
end
