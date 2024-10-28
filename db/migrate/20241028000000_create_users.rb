class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name
      # Add any other user fields you need

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end 