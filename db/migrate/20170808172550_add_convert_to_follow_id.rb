class AddConvertToFollowId < ActiveRecord::Migration[5.0]
  	change_column :followers, :follow_id, 'integer USING CAST(follow_id AS integer)'  	

end
