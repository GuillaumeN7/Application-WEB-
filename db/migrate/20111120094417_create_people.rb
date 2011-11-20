class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :firstname
      t.string :password
      t.string :login

      t.timestamps
    end
  end
end


