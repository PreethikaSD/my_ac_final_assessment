class CreateFollowers < ActiveRecord::Migration[5.0]
  def change
    create_table :followers do |t|
    	t.belongs_to :user, index: true
    	t.integer :follow_id
    	t.integer :count
    	
      t.timestamps
    end
  end
end
