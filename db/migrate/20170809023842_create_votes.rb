class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
    	t.belongs_to :note, index: true
    	t.integer :count

      t.timestamps
    end
  end
end
