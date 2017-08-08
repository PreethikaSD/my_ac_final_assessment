class RemoveFollowIdFromFollower < ActiveRecord::Migration[5.0]
  def change
  	remove_column :followers, :follow_id, :integer
  end
end
