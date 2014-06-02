class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.integer :ord_id
      t.string  :body
      t.boolean :successful

      t.timestamps
    end
  end
end
