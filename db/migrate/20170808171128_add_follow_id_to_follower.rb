class AddFollowIdToFollower < ActiveRecord::Migration[5.0]
  def change
  	add_column :followers, :follow_id, :integer  	
  end
end
