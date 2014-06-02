class RemoveShownAtFromOrds < ActiveRecord::Migration
  def change
    remove_column :ords, :shown_at
  end
end
