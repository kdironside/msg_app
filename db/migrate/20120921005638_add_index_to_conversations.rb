class AddIndexToConversations < ActiveRecord::Migration
  def change
    add_index :conversations, :user_id
    add_index :conversations, :other_id
    add_index :messages, :user_id
    add_index :messages, :conversation_id
  end
end
