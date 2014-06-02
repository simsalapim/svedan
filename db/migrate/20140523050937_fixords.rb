class Fixords < ActiveRecord::Migration
  def change
    remove_column :ords, :failure_count
    remove_column :ords, :show_count
  end
end
