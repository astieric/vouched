class ChangeStatusIdInVouch < ActiveRecord::Migration
  def self.up
    remove_column :vouches, :status_id
    add_column :vouches, :status_id, :string
  end

  def self.down
    remove_column :vouches, :status_id
    add_column :vouches, :status_id, :integer
  end
end
