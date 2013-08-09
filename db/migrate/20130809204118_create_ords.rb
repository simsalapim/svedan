class CreateOrds < ActiveRecord::Migration
  def change
    create_table :ords do |t|
      t.string :english
      t.string :swedish
      t.datetime :shown_at
      t.integer :failure_count
      t.integer :show_count

      t.timestamps
    end
  end
end
