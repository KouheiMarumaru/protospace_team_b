class RemoveprototypesIdTocomments < ActiveRecord::Migration
  def change
    remove_column :comments, :prototypes_id, :integer
  end
end
