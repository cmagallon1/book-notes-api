class AddActiveToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :disable, :datetime, default: nil
  end
end
