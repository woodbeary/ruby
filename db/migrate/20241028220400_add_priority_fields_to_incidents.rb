class AddPriorityFieldsToIncidents < ActiveRecord::Migration[7.2]
  def up
    unless column_exists?(:incidents, :submitted_priority)
      add_column :incidents, :submitted_priority, :string
    end
    
    unless column_exists?(:incidents, :suggested_priority)
      add_column :incidents, :suggested_priority, :string
    end
    
    unless column_exists?(:incidents, :final_priority)
      add_column :incidents, :final_priority, :string
    end
  end

  def down
    remove_column :incidents, :submitted_priority if column_exists?(:incidents, :submitted_priority)
    remove_column :incidents, :suggested_priority if column_exists?(:incidents, :suggested_priority)
    remove_column :incidents, :final_priority if column_exists?(:incidents, :final_priority)
  end
end
