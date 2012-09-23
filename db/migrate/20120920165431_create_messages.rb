class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :source_id
      t.text :msg_text
      t.boolean :read

      t.timestamps
    end
  end
end
