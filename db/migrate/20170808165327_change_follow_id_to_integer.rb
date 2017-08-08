class ChangeFollowIdToInteger < ActiveRecord::Migration[5.0]
  def change
  	change_column :followers, :follow_id, :integer
  end
end
