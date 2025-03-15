class AddDeletedAtToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :deleted_at, :datetime
  end
end
