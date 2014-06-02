class AddLastShownAtToOrds < ActiveRecord::Migration
  def change
    add_column :ords, :last_shown_at, :datetime
  end
end
