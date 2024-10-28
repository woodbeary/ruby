class AddPriorityFieldsToIncidents < ActiveRecord::Migration[7.1]
  def change
    # First check if users table exists
    unless table_exists?(:users)
      raise StandardError.new("Users table must exist before creating incidents")
    end

    # Only create the table if it doesn't exist
    unless table_exists?(:incidents)
      create_table :incidents do |t|
        t.string :title
        t.text :description
        t.string :status, default: 'open'
        t.references :user, foreign_key: true
        t.string :submitted_priority
        t.string :assigned_priority
        t.datetime :priority_changed_at
        t.references :priority_changed_by, foreign_key: { to_table: :users }
        t.timestamps
      end

      add_index :incidents, :submitted_priority
      add_index :incidents, :assigned_priority
    end
  end
end
