class RemoveSourceIdFromMessages < ActiveRecord::Migration
  def up
    remove_column :messages, :source_id
  end

  def down
    add_column :messages, :source_id, :integer
  end
end
