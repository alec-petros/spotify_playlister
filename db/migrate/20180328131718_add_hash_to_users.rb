class AddHashToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :spot_hash, :text
  end
end
