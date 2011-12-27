class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :note
      t.integer :post_id
      t.integer :person_id

      t.timestamps
    end
  end
end
